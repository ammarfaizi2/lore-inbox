Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSKDPZG>; Mon, 4 Nov 2002 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbSKDPZG>; Mon, 4 Nov 2002 10:25:06 -0500
Received: from mhs04ykf.blackberry.net ([206.51.26.234]:62193 "EHLO
	BlackBerry.NET") by vger.kernel.org with ESMTP id <S264711AbSKDPZF>;
	Mon, 4 Nov 2002 10:25:05 -0500
Message-Id: <200211041531.gA4FVYWp026000@BlackBerry.NET>
Content-type: text/plain
Date: Mon, 4 Nov 2002 11:31:42 -0400
From: "Shawn Starr" <shawnstarr@mobile.rogers.com>
Importance: Normal
MIME-Version: 1.0
Reply-to: "Shawn Starr" <shawnstarr@mobile.rogers.com>
Subject: Call to rewrite swsusp
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
