Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbRGXTdO>; Tue, 24 Jul 2001 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268439AbRGXTdF>; Tue, 24 Jul 2001 15:33:05 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:65015 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S268440AbRGXTc6>;
	Tue, 24 Jul 2001 15:32:58 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question about termios parameters
Date: Tue, 24 Jul 2001 15:32:57 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGOEAGCPAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.10.10107242047320.4963-100000@luxik.cdi.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	This may not be the best place to ask this, but I've done the research,
can't come up with an answer, and don't know a better group of people to
ask.

	I have an embedded Linux device (2.2.12 kernel, BlueCat distro) that uses a
serial port for the console.  When the box comes up, rc.sysinit starts the
application as a detached process (my_program&).  When the program spits out
periodic status reports, the \n is not being mapped to CR-LF (i.e., I'm
getting only linefeeds).

	Once you log on to the box (via login, into bash), the output becomes
correctly cooked.

	I've tried twiddling termios parameters for OPOST and ONLCR, but it has no
effect.  Trying to have the application run "stty -a" via a system() call
reports an error regarding it can't get the parameters for stdin.

	What parameters are required to be set for a detached process started via
init to correctly have it's output mapped from \n to CR-NL?

	--John


