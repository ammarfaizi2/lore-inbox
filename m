Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJGNAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTJGNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:00:41 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:33155 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S262306AbTJGNAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:00:39 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
X-message-flag: Please update my contact to send plain-text mail only.
Message-Id: <5.2.1.1.0.20031007054856.019687a8@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 07 Oct 2003 05:58:31 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Profiling disk usage on selected branches of a file system
In-Reply-To: <20031007130551.36899cd9.MalteSch@gmx.de>
References: <200310070631.30972.MalteSch@gmx.de>
 <200310061529.56959.domen@coderock.org>
 <200310070144.47822.domen@coderock.org>
 <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
 <200310070631.30972.MalteSch@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a number of servers that are disk-bound, and I'm trying to convince 
the boss to split out the single disk drive to separate disk drives to 
increase I/O throughput.  I've been using VMSTAT to show just how 
disk-bound we are, but I can't get any traction toward using multiple 
drives until I can show a clear, positive, and immediate benefit.

Searching the archives, I didn't see discussion of methods of monitoring 
separate parts of a file system, other than building separate partitions 
and using /proc/partitions to measure what happens there.  This isn't an 
option.  (There is some political inertia here, as well as a heavy dose of 
NIH.)

Any help welcome.

My hypothesis:  we need three separate drives, one for OS/code/swap/logs, 
one for /home (Web pages, scripts, and user data), and one devoted to 
MySQL/PostgreSQL.  The "right" way to do the job would be to have the 
databases on a completely separate computer, but that's out because of 
proprietary-software issues.

You can see the Catch-22.

Put together a single server to try the concept?  "Please, you must be 
joking,   Our servers are working just fine!"

grumble grumble NIH grumble grumble

Satch

