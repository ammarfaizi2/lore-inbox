Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUBUCnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUBUCnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:43:08 -0500
Received: from CPE-65-30-41-47.kc.rr.com ([65.30.41.47]:56262 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S261484AbUBUCnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:43:02 -0500
Message-ID: <4036C5A2.6080703@hanaden.com>
Date: Fri, 20 Feb 2004 20:42:42 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3 AGP fallback to slower speeds
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Running 2.6.3 on debian sarge and having the following problem reported 
in syslog at boot up.  Any thoughts on what is going on here and how to 
fix it?

motherboard	- soyo dragon ultra platinum kt600
video card	- ati 9000 pro 256meg
xfree		- 4.3 - says drm loads
			glxinfo says "direct rendering: No"


=== snip from lsmod ===
via_agp                 6272  1
agpgart                27308  2 via_agp
radeon                115948  2
===========

=== snip from lspci ===
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
01:00.0 VGA compatible controller: ATI Technologies Inc
	Radeon R250 If [Radeon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc
	Radeon R250 [Radeon 9000] (Secondary) (rev 01)
=============

== from syslog ==
Feb 20 19:20:50  kernel: agpgart: Found an AGP 3.5
	compliant device at 0000:00:00.0.
Feb 20 19:20:50  kernel: agpgart: Device is in legacy mode,
	falling back to 2.x
Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
	at 0000:00:00.0 into 1x mode
Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
	at 0000:01:00.0 into 1x mode
Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
	at 0000:01:00.1 into 1x mode
==========
