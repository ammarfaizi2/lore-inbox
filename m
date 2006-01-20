Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWATUbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWATUbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWATUbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:31:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38161 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932167AbWATUbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:31:05 -0500
Date: Fri, 20 Jan 2006 21:31:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Tony Mantler <nicoya@ubb.ca>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Message-ID: <20060120203104.GA31803@stusta.de>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca> <20060120044407.432eae02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120044407.432eae02.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:44:07AM -0800, Andrew Morton wrote:
> Tony Mantler <nicoya@ubb.ca> wrote:
> >
> > I'm having trouble running lsof on 2.6.15.1 when the kernel is  
> > compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
> > when run as a user lsof will hang unkillable.
> > 
> > The same kernel, same machine, but compiled with CONFIG_MK7 runs just  
> > lsof just fine.
> 
> That's creepy.  CONFIG_MK6 hardly does anything.  The main thing it does is
> feed `-march=k6' into the compiler.  MK7 uses `-march=athlon'.
>...

CONFIG_MK7 results in a bigger L1_CACHE_SHIFT than CONFIG_MK6.

AFAIR it wouldn't be the first time that changing L1_CACHE_SHIFT would 
hide a real bug visible with a different L1_CACHE_SHIFT.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

