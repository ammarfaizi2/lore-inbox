Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTLFOdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTLFOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:33:00 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265177AbTLFOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:32:59 -0500
Date: Sat, 6 Dec 2003 14:37:55 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312061437.hB6EbtFs000167@81-2-122-30.bradfords.org.uk>
To: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20031206084032.A3438@animx.eu.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
 <3FD1994C.10607@stinkfoot.org>
 <20031206084032.A3438@animx.eu.org>
Subject: Re: cdrecord hangs my computer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the moment, I don't have a burner on a 2.6.0 machine, however, why is
> ide-scsi depreciated?

Basically IDE-SCSI is a work-around to allow userspace programs that
were designed to talk to SCSI devices to use SCSI-like devices
connected to an IDE bus.

This works, but obviously it is better to support things natively.
IDE CD recorders are probably the most popular SCSI-like IDE device
and were therefore quickly supported.  Less common hardware, such as
some IDE MO drives, continues to require IDE-SCSI for the time being.

> On every PC I have that has an ide cd drive, I use
> ide-scsi.  I like the fact that scd0 is the cdrom drive.  Instead of
> guessing if it's hdb hdc or hdd (in the case of this laptop, the dvd was hdb
> and the modular cdrw was hdc).

It's easy enough to write something in userspace to identify which
devices are which and create devices such as /dev/cdrom
automatically - no need to use IDE-SCSI for that.

John.
