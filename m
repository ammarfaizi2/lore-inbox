Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbRDCNeU>; Tue, 3 Apr 2001 09:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRDCNeL>; Tue, 3 Apr 2001 09:34:11 -0400
Received: from smtppop1pub.gte.net ([206.46.170.20]:12824 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S131709AbRDCNdx>; Tue, 3 Apr 2001 09:33:53 -0400
Message-ID: <3AC9D108.CBE9C2BB@gte.net>
Date: Tue, 03 Apr 2001 09:32:56 -0400
From: "Stephen E. Clark" <sclark46@gte.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trevor Nichols <ocdi@ocdi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
In-Reply-To: <Pine.BSF.4.33.0104032217220.60098-100000@ocdi.sb101.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That happened to me with 2.4.2-ac28 when I tried using DRM.
I also got the following messages in syslog.

/var/log/messages.1:Mar 31 12:15:04 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:15:04 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:15:15 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:15:15 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:15:16 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:15:40 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:18 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:31 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:32 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:45 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:45 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:48 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!
/var/log/messages.1:Mar 31 12:16:49 joker kernel:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!/

So I turned off DRI in X 4.0.3

HTH
Steve

Trevor Nichols wrote:
> 
> Hi all,
> 
> Since upgrading to the latest stable (2.4.3) kernel, I've noticed that
> randomly some processes are going into an uninteruptable sleep and not
> waking up at all.
> 
> It's happened to nautilus and today just happened to mozilla also.
> Another common related problem is the load averages go up to n + "normal"
> where n is the number of processes that have gone uninteruptable sleep.
> This is making me think it's a kernel related problem.
> 
> I had one time where nautilus with 9 [presumably forked] processes of
> itself go this way, causing load averages to go 9+, however the system
> doesn't appear to be straining or strugling under that much load.
> 
> The previous kernel version that I was using (2.4.1) did not have this
> problem.
> 
> One last thing, if this turns out to be a non-kernel problem, the
> processes that *do* get stuck, are unkillable - even by root with SIGKILL.
> Is there any way for it to be able to? :)  So far I have to reboot each
> time it happens.
> 
> Best regards,
> Trevor Nichols.
> 
> ps please CC replies to my address. thanks.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
