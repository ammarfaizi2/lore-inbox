Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSIDXDd>; Wed, 4 Sep 2002 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSIDXDd>; Wed, 4 Sep 2002 19:03:33 -0400
Received: from windsormachine.com ([206.48.122.28]:14093 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S315925AbSIDXDc>; Wed, 4 Sep 2002 19:03:32 -0400
Date: Wed, 4 Sep 2002 19:07:59 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Intel Etherexpress PCI ID
Message-ID: <Pine.LNX.4.33.0209041849230.30436-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just snagged ac5-pre2, and noticed there isn't a PCI ID yet for the
intel network chipset built into the ASUS P4B533-E w/raid motherboard(bios
version 1008) I bought today.

  Bus  2, device   8, function  0:
    Ethernet controller: PCI device 8086:1039 (Intel Corp.) (rev 129).

I put

        { PCI_VENDOR_ID_INTEL, 0x1039, PCI_ANY_ID, PCI_ANY_ID, },

just below the 0x1038 line in eepro100.c, and it works fine.

I assume the promise card is supported now, from browsing through the
changes.  I believe it's a 20276.

I didn't have problems with the ICH4 that others have reported on this
board, DMA mode works.  Does the usual complain about resource collisions
though.

Mike

