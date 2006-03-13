Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWCMTHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWCMTHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWCMTHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:07:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18957 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751748AbWCMTHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:07:15 -0500
Date: Mon, 13 Mar 2006 20:07:14 +0100
From: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Pavlik Vojtech <vojtech@suse.cz>, Ryan Phillips <rphillips@gentoo.org>,
       Duncan <1i5t5.duncan@cox.net>, Meelis Roos <mroos@linux.ee>
Subject: 2.6.16-rc6: all psmouse regressions fixed?
Message-ID: <20060313190714.GD13973@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
>...
> Dmitry Torokhov:
>       Input: psmouse - disable autoresync
>...

We had the three psmouse regressions below in 2.6.16-rc5.

Duncan already stated that this patch fixed (more exactly: works around) 
his problems.

Does anyone still observe a psmouse regression in 2.6.16-rc6 compared 
to 2.6.15, or is everything fine now?


Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
Submitter  : Ryan Phillips <rphillips@gentoo.org>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
Status     : workaround: psmouse.resync_time=0

Subject    : total ps2 keyboard lockup from boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=6130
Submitter  : Duncan <1i5t5.duncan@cox.net>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
             Pavlik Vojtech <vojtech@suse.cz>
Status     : discussion and debugging in the bug logs

Subject    : psmouse starts losing sync in 2.6.16-rc2
References : http://lkml.org/lkml/2006/2/5/50
Submitter  : Meelis Roos <mroos@linux.ee>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
Status     : Dmitry: Working on various manifestations of this one.
                     At worst we will have to disable resync by default
                     before 2.6.16 final is out and continue in 2.6.17 cycle.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

