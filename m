Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRKSQqc>; Mon, 19 Nov 2001 11:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280015AbRKSQqW>; Mon, 19 Nov 2001 11:46:22 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:63237 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S280027AbRKSQqL>; Mon, 19 Nov 2001 11:46:11 -0500
Date: Mon, 19 Nov 2001 12:48:24 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: pci_write_config_byte question..
Message-ID: <Pine.LNX.4.33.0111191243570.237-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been hacking some PCI code to get USB working on my laptop.  I need
to change PCI config space to use IRQ 11 for the device instead of IRQ 9.

So i call pci_write_config_byte(...), but that only appears to change the
"system" view of PCI space.. if you boot the kernel and do an lspci, it
shows up as IRQ11, but if you do a lspci -b (for "Bus" view), it still
shows up as IRQ 9.

my question:  why doesn't pci_write_config_byte not seem to work as
advertised? it just seems to manipulate a data structure...?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


