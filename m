Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJFOZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTJFOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:25:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:48256 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262128AbTJFOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:25:20 -0400
Date: Mon, 6 Oct 2003 15:25:43 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310061425.h96EPhkP000548@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mikael Pettersson <mikpe@csd.uu.se>
Cc: Dave Jones <davej@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310060932340.8753@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos>
 <20031003235801.GA5183@redhat.com>
 <Pine.LNX.4.53.0310060834180.8593@chaos>
 <16257.26407.439415.325123@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0310060932340.8753@chaos>
Subject: Re: FDC motor left on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you can end up with another floppy drive motor on under
> any condition when the kernel is given control, then you
> can simply reset both (or all) floppy motor control bits.

This is not a problem to deal with in the kernel - what if there is
hardware other than a floppy controller at that address?

The bootloader needs to ensure that the hardware is at least in a
sensible state when the kernel is entered.  Infact, unless the system
is being booted from floppy, why is the BIOS accessing the floppy at
all?

Re-configure the BIOS not to try to boot from the floppy, or to seek
the drive to see whether it is capable of 40 or 80 tracks.

If that is not possible, (on a laptop with an obscure BIOS for
example), add a delay to the bootloader.  Assumng interupts are still
enabled, the BIOS will switch the floppy off after a few seconds.

John.
