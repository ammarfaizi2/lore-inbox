Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWDFWhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWDFWhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDFWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:37:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7431 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932180AbWDFWhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:37:18 -0400
Date: Fri, 7 Apr 2006 00:37:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, rdunlap@xenotime.net, fastboot@osdl.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
Message-ID: <20060406223716.GB7118@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404162921.GK6529@stusta.de> <4432AB57.1040006@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4432AB57.1040006@vmware.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 10:22:31AM -0700, Zachary Amsden wrote:
>...
> Voyager SMP builds don't compile with kexec(), and it isn't clear how to 
> shootdown CPUs using NMIs without an APIC.
>...
>  config KEXEC
>  	bool "kexec system call (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
> +	depends on EXPERIMENTAL && !(X86_VOYAGER && SMP)
>...

Unless James disagrees with me, I'd prefer to let X86_VOYAGER depend on 
SMP (the CONFIG_SMP=n case is anyways not compiling), and you could 
express this simply as "&& !X86_VOYAGER".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

