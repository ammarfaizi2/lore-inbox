Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130072AbQK1CVs>; Mon, 27 Nov 2000 21:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130146AbQK1CV2>; Mon, 27 Nov 2000 21:21:28 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:5395
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S130072AbQK1CVU>; Mon, 27 Nov 2000 21:21:20 -0500
Date: Mon, 27 Nov 2000 17:50:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bjorn Wesen <bjorn@sparta.lu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-driver not generalized enough ?
In-Reply-To: <Pine.LNX.3.96.1001128011205.21838E-100000@medusa.sparta.lu.se>
Message-ID: <Pine.LNX.4.10.10011271735210.16898-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I have been working on that for some time.
This requires that the macros be exported the arch-xxx/ide.h
Additionally it takes more work to modify the request_io and release_io,
but it is all doable.

On Tue, 28 Nov 2000, Bjorn Wesen wrote:

> Hi! Quick question: is it possible to write an IDE driver for a controller
> that is not mappable using outp and those memory-mapped thingys ? 
> 
> I see all the nice overrideables in struct hwif_s but the main code still
> uses OUT_BYTE which is hardcoded to an outb_p.. non-overrideable. Same
> thing with ide_input/output_bytes, they do direct in/out accesses also
> without consulting any hwif specific routine.
> 
> So what do I do if my controller does not have a simple memory-mapping for
> each IDE-register into the memory ? Do I have to clutter ide.h and ide.c
> with #ifdef's or is there any cleaner abstraction on the way (something
> like adding a hwif field to perform the OUT/IN-byte stuff, and
> ide_xxput_bytes) ?
> 
> (I have a solution working by replacing OUT_BYTE and ide_xxput_bytes, but
> wanted to make it without having to patch the "official" ide.c/ide.h)
> 
> Regards,
> Bjorn
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
