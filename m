Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUB0K6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUB0K4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:56:45 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:61449 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261797AbUB0Kzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:55:52 -0500
Message-ID: <403F2237.6080505@dcrdev.demon.co.uk>
Date: Fri, 27 Feb 2004 10:55:51 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard locks under high interrupt load?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having zero success in getting 2.6.3 stable under interrupt load.  I 
can kill my machine in a variety of fashions all of which appear, to my 
naive eye, related to interrupt load:

(1)   LAN traffic via E1000 card (X is not running)
(2)   Running X for more than a few minutes - starting up a couple of 
applications whilst performing some disk-based activity (such as a 
compile) usually seems to do the trick.

(2) is worth a little more examination.  I have an NVIDIA card (I can 
hear you all groan) *but* I get the same results with the XFree driver 
*or* the proprietary NVIDIA driver.

Disabling IO-APIC usage seems to resolve the problem.

Machine is a dual Xeon, Tyan S2665 (E7505 chipset) with an MPT-Fusion 
SCSI controller.

2.4.26-pre1 and various other 2.4 kernels give me no problems at all.  I 
really want to switch my machines over to 2.6 but I can't whilst this 
problem persists.

Cheers,

Dan.

