Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUE3R0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUE3R0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUE3R0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:26:19 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:12887 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264228AbUE3R0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:26:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 12:26:05 -0500
User-Agent: KMail/1.6.2
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040530121606.GA1496@ucw.cz> <xb7ekp29jgg.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7ekp29jgg.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301226.05596.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 07:40 am, Sau Dan Lee wrote:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
>     >> Where it is now possible to move it out of kernel space WITHOUT
>     >> performance problems, why not move it out?
> 
>     Vojtech> Because it just works.
> 
>     Vojtech> 1) Upgrading the kernel will make your keyboard stop
>     Vojtech> working. Noone has installed your userspace daemons on
>     Vojtech> the system.
> 
> Many people has already fallen  into this trap with YOUR input system:
> they didn't know they had  to enable the 'i8042' and 'atkbd' features,
> or they did  but made them modules and didn't have  any clue to insmod
> them in the bootup scripts.

This was in development series (2.5) and was resolved by the time 2.6 came
out so I really do not think it's a valid complaint.
 
>     Vojtech> 2) The keyboard (and other input devices, so that you
>     Vojtech> don't complain about limiting this to the keyboard)
>     Vojtech> should work without requiring userspace to be running.
> 
> Is a network interface an input device?  Or do you just mean HID?
> 
> USB devices  (including USB keyboards  and mice) require  hot-plug (or
> similar mechanisms) to load  the corresponding modules before they can
> work.   Both  /sbin/hotplug  and   /sbin/modprobe  on  my  system  are
> userspace programs.
> 
> 

>     Vojtech> And, it works just fine in the kernel, doesn't take up
>     Vojtech> any more space than as a program, so why to move it out?
> 
> To leave more *swappable* RAM to userspace.
> 

On average it will take much more considering that you better have your
keyboard daemon linked statically and residing.. umm.. initrd?  initramfs?
as you want your keyboard working very early.

>     >> Yeah.  At what rate are they arriving?  1200baud.  Let's say
>     >> that' 9600bps.  So, 1200 bytes per second.  1 byte in every 833
>     >> microseconds.  How come a processor at 33MHz (0.030
>     >> microseconds per clock cycle) cannot cope with that?  Assuming
>     >> that the processing of the data plus context switching plus
>     >> other overhead taks 1000 microseconds, that still shouldn't be
>     >> felt by a HUMAN user.  Who has a reaction time of less than 100
>     >> _milli_seconds?
> 
>     Vojtech> Can you say swap?
> 
> Can you say mlock()?
> 

I though you wanted the thing to be swapped out? Btw, what are you going
to mlock? Entirety of glibc?

-- 
Dmitry
