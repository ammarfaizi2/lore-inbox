Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWABAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWABAFP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 19:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWABAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 19:05:15 -0500
Received: from europa.telenet-ops.be ([195.130.137.75]:13461 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932290AbWABAFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 19:05:14 -0500
Subject: Need help with mtrr & agpgart
From: Ochal Christophe <ochal@kefren.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 02 Jan 2006 01:52:01 +0100
Message-Id: <1136163121.8522.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing a little digging in my system since i was unable to get
DRI running on my current motherboard (see my prior posts regarding a
possible bug in agpgart), and i noticed that i don't get any lines
in /proc/mtrr expect for my main memory.

The entry seems correct, the size specified is also correct, however, i
don't get any write-combining lines.

This is what i get:

eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1

This is what i should get:
eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1
reg02: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1

The required modules are loaded (agpgart & amd64-agp), but as previously
reported, amd64-agp is unable to read the proper aperture size.

As far as i've come to understand, these issue's are most likely
related, and quite possibly related to the motherboard BIOS, so i'm
wondering about any work-arrounds for this.

Cheers all

