Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUBXNzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUBXNzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:55:11 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58834 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262172AbUBXNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:55:05 -0500
Message-ID: <403B57B8.2000008@acm.org>
Date: Tue, 24 Feb 2004 07:55:04 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] IPMI driver updates, part 1b
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like part 1 of the IPMI driver updates was a little too big to 
get through.  So I've split it up.  Part 1a and part1b must both be 
applied.  Here's the original message.  Also, this is for the 2.6.3 kernel.

It has been far too long since the last IPMI driver updates, but now all 
the planets have aligned and all the pieces I needed are in and all seem 
to be working.  This update is coming as four parts that must be applied 
in order, but the later parts do not have to be applied for the former 
parts to work.

This first part does basic updates to the IPMI infrastructure.  It adds 
support for messaging through an IPMI LAN interface, which is required 
for some system software that already exists on other IPMI drivers.  It 
also does some renaming (in preparation for one of the later patches) 
and a lot of little cleanups.

FYI, IPMI is a standard for monitoring and maintaining a system.  It 
provides interfaces for detecting sensors (voltage, temperature, etc.) 
in the system and monitoring those sensors.  Many systems have extended 
capabilities that allow IPMI to control the system, doing things like 
lighting leds and controlling hot-swap.  This driver allows access to 
the IPMI system.

-Corey

