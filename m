Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVBTKtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVBTKtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVBTKtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:49:10 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:33957 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S261810AbVBTKsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:48:06 -0500
Message-ID: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in>
Date: Sun, 20 Feb 2005 16:28:17 +0530 (IST)
Subject: Needed faster implementation of do_gettimeofday()
From: puneet_kaushik@persistent.co.in
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am running oprofile on some program. Following is the oprofile output.

-----------------------------------------------------------------------

Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
985913    8.6083  vmlinux                  mark_offset_tsc
584473    5.1032  libc-2.3.2.so            getc
295901    2.5836  vmlinux                  ide_outb
270823    2.3646  vmlinux                  _spin_lock
249791    2.1810  vmlinux                  _spin_unlock
236140    2.0618  vmlinux                  timer_interrupt
175249    1.5302  ld-2.3.2.so              do_lookup_versioned
140429    1.2261  sendmail                 putc
138739    1.2114  sendmail                 stabhash
134145    1.1713  sendmail                 getc

-----------------------------------------------------------------------


>From this output what I can analyse is that mark_offset_tsc(which is
called from do_gettimeofday), and some other timer functions, are taking
most of the CPU.

Is there any faster implementation of do_gettimeofday. I am using kernel
2.6.10. with dual P4.

What I found from google search is: http://lwn.net/Articles/9266/ , which
is only for kernel 2.4

Thanks for help.


-Puneet



