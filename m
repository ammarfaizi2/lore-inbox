Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJ2OvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJ2OvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:51:06 -0500
Received: from main.gmane.org ([80.91.224.249]:20930 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261602AbTJ2OvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:51:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christian Kapeller <the_kapeller@gmx.at>
Subject: [2.6.0-test9] alsa intel8x0: scattered sound playback
Date: Wed, 29 Oct 2003 15:41:55 +0100
Message-ID: <slrnbpvkdj.845.christian.kapeller@campus14.panorama.sth.ac.at>
Reply-To: Christian Kapeller <the_kapeller@gmx.at>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since i'm running the 2.6.0 (2.6.0-test9-bk1 currently) kernel i encounter 
problems with alsa sound playback.

I got a Thinkpad A31 with Debian, so i use the intel8x0 driver. I compiled the 
drivers into the kernel. The compiling works just fine, also the sound playback 
runs without problems.

The sound is very scatterd and parts of the playback are repeated sometims. 
Stopping the playback and starting it again, fixes it - somtimes, and if then 
only for a couple of seconds.

I tested it with xmms (output: libALSA.so and libesdout.so), mpg123 and mplayer.
I tried it with and without esd.


lspci reports:
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)



/var/log/kern.log shows the following error messages:

----
Oct 28 18:18:08 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -1314, max jitter = 8192): wrong interrupt acknowledge?
Oct 28 18:18:08 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -1024, max jitter = 8192): wrong interrupt acknowledge?
Oct 28 18:19:29 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -1084, max jitter = 8192): wrong interrupt acknowledge?
Oct 28 18:19:29 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -1024, max jitter = 8192): wrong interrupt acknowledge?
--


I searched the web but didn't find a similar problem.
Does anyone have a clou?

