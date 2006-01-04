Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWADUyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWADUyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWADUyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:54:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030286AbWADUyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:54:54 -0500
Date: Wed, 4 Jan 2006 21:54:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: spinlockup in kacpid of 2.6.15-rc6 during boot
Message-ID: <20060104205452.GU3831@stusta.de>
References: <43B8B2EB.8010709@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B8B2EB.8010709@lwfinger.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 10:58:19PM -0600, Larry Finger wrote:
> I am getting an intermittent "BUG: spinlockup on CPU #0, kacpid/13, 
> e3bcef9c" message when booting. I know it occurs from a cold boot, but am 
> not sure about from a warm reboot.
> 
> I don't know where in the boot sequence it occurs as I only have the text 
> display on the screen, which is as follows:

You can set a higher resolution using the vga= boot parameter (see 
Documentation/kernel-parameters.txt in the kernel sources).

> ...... unknown material that rolled off the top of the screen
> _spinlock + 0x1b/0x30
> exit_io_context + 0x25/0x90
> do_exit + 0x54/0x430
> die + 0x17c/0x180
> do_page_fault + 0x209/0x62e
> error_code + 0x4f/0x54
> show_stack + 0x9c/0x0e
> show_registers + 0x18f/0x230
> die + 0xfa/0x180
> do_page_fault + 0x209/0x62e
> BUG: spinlockup on CPU #0, kacpid/13, e3bcef9c
> dump_stack + 0x1e/0x20
> __spin_lock_debug + 0xb6/0xf0
> _raw_spin_lock + 0x67/0x90
> _spinlock + 0x1b/0x30
> exit_io_context + 0x25/0x90
> do_exit + 0x54/0x430
> die + 0x17c/0x180
> do_page_fault + 0x209/0x62e
> error_code + 0x4f/0x54
> show_stack + 0x9c/0x0e
> show_registers + 0x18f/0x230
> die + 0xfa/0x180
> do_page_fault + 0x209/0x62e
> 
> The computer is an HP ze1115 notebook with a mobile K7 processor. The 
> beginning lines of a normal dmesg are:
> 
> Linux version 2.6.15-rc6 (root@linux) (gcc version 4.0.2 20050901 
> (prerelease) (SUSE Linux)) #4 PREEMPT
>...

IOW, 2.6.15-rc6 does sometimes boot, and sometimes it doesn't boot?

Can you give information regarding which kernel versions are affected 
and which aren't, and what influences whether 2.6.15-rc6 does boot or 
does not boot?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

