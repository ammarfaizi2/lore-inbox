Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQLFWEF>; Wed, 6 Dec 2000 17:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbQLFWD4>; Wed, 6 Dec 2000 17:03:56 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24842
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130304AbQLFWDk>; Wed, 6 Dec 2000 17:03:40 -0500
Date: Wed, 6 Dec 2000 13:33:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Lamanna <jlamanna@its.caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PDC202xx driver
In-Reply-To: <3A2EACE3.3D4BD3C2@its.caltech.edu>
Message-ID: <Pine.LNX.4.10.10012061327260.23184-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, James Lamanna wrote:

> So you are saying that the Promise Fasttrak 100 chipset is
> designed wrong? Because that's exactly what I have.
> and isn't this driver supposed to support it?
> Or are you saying the IDE controller on the MB is wrong?

Clarify things first.

PDC20267 is the Ultra100 core.
PDC20267 w/ a pull-up resistor reports its device class as RAID, Fasttrak100.

Now if you have a device that reports it storage class as RAID then it may
misbehave.  Otherwise, if it is reporting "Unknown Mass Storage" then you
have an Ultra/ATA controller.

There are two different BIOS cores for each design.
Linux cleanly supports the BIOS cores know as "Ultra" and not the ones
know as "Fasttrak".

Because there are different PCI config space setups for each core then we
have a problem unless we go and poke around for storage classes.

Does that help?


Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
