Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129210AbQK0THW>; Mon, 27 Nov 2000 14:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129379AbQK0THL>; Mon, 27 Nov 2000 14:07:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57348 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129210AbQK0THH>; Mon, 27 Nov 2000 14:07:07 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
Date: 27 Nov 2000 10:36:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vu9ji$r2a$1@cesium.transmeta.com>
In-Reply-To: <00112614213105.05228@paganini> <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
By author:    Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
In newsgroup: linux.dev.kernel
> 
> I hope count isn't provided by userspace here ?
> 
> > 1. What happens if the user space memory is swapped to disk? Will 
> > verify_area() make sure that the memory is in physical RAM when it returns, 
> > or will it return -EFAULT, or will something even worse happen?
> 
> On i386, you'll sleep implicitly waiting for the page fault to be handled;  in
> the generic case, anything could happen.
> 

That doesn't sound right.  I would expect it to wait for the page to
be brought in on any and all architectures, otherwise it seems rather
impossible to write portable Linux kernel code.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
