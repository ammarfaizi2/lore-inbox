Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULAKUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULAKUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbULAKUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:20:49 -0500
Received: from 211-23-141-2.HINET-IP.hinet.net ([211.23.141.2]:35081 "EHLO
	www.softwell.com.tw") by vger.kernel.org with ESMTP id S261352AbULAKUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:20:33 -0500
Subject: Kernel 2.6 with X (xorg) 4.4 (eats more CPU power)
From: Joe Hsu <joe@softwell.com.tw>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1101896505.2161.45.camel@joe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 01 Dec 2004 18:21:45 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All:
    I've tried libXv to open an Video Overlay port and
XvShmPutImage for 60 frames per second. Each frame is
at a size of 800x600 using format YUYV (YUV2). Before
each XvShmPutImage, I copy 800x600x2 bytes of non-constant 
data to XvImage->data. (No user interactive UI)

    And I found something interisting happened. In pentium 4
3.0G machine and linux kernel 2.6, X and my program total 
consumes 5% of cpu resource.

    But in pentium 4 2.xG or below, it would consume 10% or 
more of CPU resource. (If you try this with XFree86 4.2 and 
pentium 1.xG machine, it would consume 30% or more of cpu 
resource at a peak.)

    In contrast, I've tried Kernel 2.4 with same X, same 
program, and same machine. It consumes almost zero of CPU 
resource( no matter it runs on a P4 1.xG or P4 3.0G and no
matter it runs on 4.4 or 4.2 X-server).

    Same phenomenon happened when I ran 4 mpeg4 playback 
programs (each 320x240, 30 frames per second, no scaling).
It seems that these programs and X consume almost zero of 
CPU power when the KERNEL HZ is 100. (I've 
tried Robert Love's variable HZ patch to kernel 2.4 and 
change HZ to 1000........Same phenomenon as 2.6)

    Could any one explain why??? Thanks.
(I wish to be personally CC'ed the answers/comments posted 
to the list in response to your posting 'cause I do not 
subscribe to this mailing list.)

