Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBMXty>; Tue, 13 Feb 2001 18:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBMXtq>; Tue, 13 Feb 2001 18:49:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:12711 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129075AbRBMXt2>;
	Tue, 13 Feb 2001 18:49:28 -0500
Date: Wed, 14 Feb 2001 00:49:24 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102132349.AAA97331.aeb@vlet.cwi.nl>
To: michael_e_brown@dell.com
Subject: Re: block ioctl to read/write last sector
Cc: Matt_Domsch@exchange.dell.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From michael_e_brown@dell.com Wed Feb 14 00:37:25 2001

    > Look at the addpart utility in the util-linux package.
    > It will allow you to add a partition disjoint from
    > previously existing partitions.
    > And since a partition can start on an odd sector,
    > this should allow you to also read the last sector.
    >
    > Do I overlook something?

    Yes. The addpart utility just uses the block-layer ioctls to dynamically
    add and/or remove partitions. What this is doing is just adjusting the
    kernel's idea of what the current partition scheme is. This has _nothing_
    to do with actually reading or writing data from the disk.

But it changes the idea of odd and even.
A partition can start on an odd sector.

Andries
