Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTHSL4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 07:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbTHSL4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 07:56:08 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:62092 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S270321AbTHSL4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 07:56:06 -0400
Date: Tue, 19 Aug 2003 13:48:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: John Bradford <john@grabjohn.com>
cc: herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
In-Reply-To: <200308190737.h7J7bVaa000623@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.GSO.3.96.1030819133312.28761A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, John Bradford wrote:

> On some boards I've seen, there is 384K onboard for ROM shadowing
> purposes, and when only 128K is actually used, (as it is in a lot of
> configurations), the other 256K is available as system memory.
> 
> However, this on-board 256K is only remapped when you have 8 MB RAM or
> less on the board.  So with 8 MB the board reports 8448K of RAM, but
> with 16 MB, it only reports 16384K.  In that case 256K of real RAM is,
> indeed, lost.

 Since the system firmware of a typical PC these days is compressed in the
ROM, part of the RAM in the upper 384kB of the first MB of physical
address space is used to hold an uncompressed image of the firmware --
typically 128kB.  The preceding 128kB is available for shadowing firmware
of option boards and the remaining 128kB is used for SMM code or not at
all.  Remapping of these 384kB of RAM in the chipset for general use is
possible in some systems, but I haven't seen this option in any system
newer than ones from the 486 era. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

