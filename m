Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCTXTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCTXTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCTXQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:16:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48904 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261344AbVCTXMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:12:34 -0500
Date: Mon, 21 Mar 2005 00:12:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386/x86_64 mpparse.c: kill maxcpus
Message-ID: <20050320231232.GY4449@stusta.de>
References: <20050320192549.GP4449@stusta.de> <20050320224233.GB26230@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320224233.GB26230@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 05:42:34PM -0500, Dave Jones wrote:
> On Sun, Mar 20, 2005 at 08:25:49PM +0100, Adrian Bunk wrote:
>  > Do we really need a global variable that does only hold the value of 
>  > NR_CPUS?
> 
> Yes.
>  
> NR_CPUS = compile time
> maxcpus = boot command line at runtime.

If this is how is was expected to work - it isn't exactly what is 
currently implemented.

The function maxcpus in init/main.c sets a static variable max_cpus -
not the global variable maxcpus in the mpparse.c files.

How should it be?

Should max_cpus in init/main.c become global and replace the maxcpus 
from the mpparse.c files?

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

