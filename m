Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSGTXWq>; Sat, 20 Jul 2002 19:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGTXWq>; Sat, 20 Jul 2002 19:22:46 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:4785 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S317571AbSGTXWp>; Sat, 20 Jul 2002 19:22:45 -0400
Date: Sat, 20 Jul 2002 18:25:49 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: <linux-kernel@vger.kernel.org>
Subject: Zaptel Pseudo TDM Bus
Message-ID: <Pine.LNX.4.33.0207201814170.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Enthusiasts:

	Over the past year, Linux Support Services, Inc.  and Zapata
Telephony, Inc. have been working together on building the "Zaptel" pseudo
TDM bus architecture, and having at least 7 supported boards in a variety
of roles (T1, E1, multi-port T1, E1, FXS and FXO with USB, PCI, ISA, and
Ethernet interfaces), we are now interesting in getting comments on the
driver architecture and moving towards integration into the 2.5 kernel.

	The Zaptel telephony infrastructure differs substantially from the
existing Linux telephony structure, because it's designed to produce a
framework for creating a "pseudo TDM" bus inside the kernel, allowing
features like conferencing, DAXing, bridging, echo cancellation, HDLC
packetization, and other resources typically done in hardware to be
replaced by software, by simulating a TDM bus in the Linux kernel (thanks
to its remarkably thin interrupt latency).

	The driver framework (and associated user-space library) currently
handles a variety of interfaces (including T1, E1, PRI, FXS, FXO, E&M,
Feature Group D) and features (DTMF detection, echo cancellation,
conferencing, digital gain adjustment, HDLC data modes via SyncPPP, frame
relay, ISDN RAS, etc etc).  Drivers for new hardware are very simple to
add, and channels from one driver can be bridged to those of another
driver, even if their timings are not synchronized.

	The primary application we use on this interface (although
certainly not the only one) is the Asterisk Open Source PBX
(http://www.asterisk.org) which permits you to build a full featured PBX
(Private Branch eXchange) or IVR (Interactive Voice Response) server with
a Linux box.  Using the zaptel infrastructure, Asterisk provides the
ability to deploy phone service with all your expected call features etc.

	For more information, go to http://www.linux-support.net, or
http://www.asterisk.org.

	I am very interested in seeking comments both on our driver
framework, and on how to go about submitting this for kernel inclusion if
appropriate.

Mark

