Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264712AbSKDPdG>; Mon, 4 Nov 2002 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKDPdG>; Mon, 4 Nov 2002 10:33:06 -0500
Received: from bbf01.blackberry.net ([206.51.26.90]:20649 "EHLO
	MRS.ISPserver.BlackBerry.NET") by vger.kernel.org with ESMTP
	id <S264712AbSKDPdF>; Mon, 4 Nov 2002 10:33:05 -0500
Content-type: text/plain
Date: Mon, 4 Nov 2002 11:39:36 -0400
From: "Shawn Starr" <shawnstarr@mobile.rogers.com>
Importance: Normal
MIME-Version: 1.0
Reply-to: "Shawn Starr" <shawnstarr@mobile.rogers.com>
Subject: Re: Call to rewrite swsusp
To: linux-kernel@vger.kernel.org
Message-Id: <20021104153305Z264712-32597+15620@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make that: Tell all generic subsystems to clear their buffers out and tell other subsystems they are not available. Suspend first then APM/ACPI last. Perhaps we need some sort of flag states to let other kernel subsystems know not to bother asking for requests. The kernel could preempt each subsystem and bring them down in a safe order no?

Shawn.

-----Original Message-----
From: "Shawn Starr" <shawnstarr@mobile.rogers.com>
Date: Mon, 4 Nov 2002 11:31:42 
To: linux-kernel@vger.kernel.org
Subject: Call to rewrite swsusp


Talking with some people last night it seems we need to redo the swsusp (driver). From what I've been told and have seen (from the code) it doesn't talk to the generic subsystems (like block layer, network layer etc). From talks with some kernel developers, they tell me we would have to modify all the drivers to properly handle system suspends. Is it not APM/ACPI's job to bring down the system to a stable state when suspending the machine?

The swsusp should be asking all the generic subsystems. When the machine is about to be suspended it should flush any read/write buffers, stop processing packets and other things.

Am I totally wrong on this? :-)

Shawn.
Shawn Starr
Development Systems Support Analyst, Operations
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
www.datawire.net
"Sent from my Blackberry handheld"
Shawn Starr
Development Systems Support Analyst, Operations
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
www.datawire.net
"Sent from my Blackberry handheld"
