Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129772AbQK1CCP>; Mon, 27 Nov 2000 21:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129823AbQK1CCF>; Mon, 27 Nov 2000 21:02:05 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:22581 "EHLO
        medusa.sparta.lu.se") by vger.kernel.org with ESMTP
        id <S129772AbQK1CBy>; Mon, 27 Nov 2000 21:01:54 -0500
Date: Tue, 28 Nov 2000 01:12:28 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: IDE-driver not generalized enough ?
Message-ID: <Pine.LNX.3.96.1001128011205.21838E-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Quick question: is it possible to write an IDE driver for a controller
that is not mappable using outp and those memory-mapped thingys ? 

I see all the nice overrideables in struct hwif_s but the main code still
uses OUT_BYTE which is hardcoded to an outb_p.. non-overrideable. Same
thing with ide_input/output_bytes, they do direct in/out accesses also
without consulting any hwif specific routine.

So what do I do if my controller does not have a simple memory-mapping for
each IDE-register into the memory ? Do I have to clutter ide.h and ide.c
with #ifdef's or is there any cleaner abstraction on the way (something
like adding a hwif field to perform the OUT/IN-byte stuff, and
ide_xxput_bytes) ?

(I have a solution working by replacing OUT_BYTE and ide_xxput_bytes, but
wanted to make it without having to patch the "official" ide.c/ide.h)

Regards,
Bjorn


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
