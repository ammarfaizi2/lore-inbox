Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273102AbRIIXv4>; Sun, 9 Sep 2001 19:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273101AbRIIXvq>; Sun, 9 Sep 2001 19:51:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46087 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273106AbRIIXvl>; Sun, 9 Sep 2001 19:51:41 -0400
Subject: Re: linux-2.4.10-pre5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 10 Sep 2001 00:54:26 +0100 (BST)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        adilger@turbolabs.com (Andreas Dilger),
        andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0109091615570.22033-100000@penguin.transmeta.com> from "Linus Torvalds" at Sep 09, 2001 04:24:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15gEPC-00084T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you plan to handle the situation where we have multiple instances
of the same 4K disk block each of which contains 1K of data in the
start of the page copy and 3K of zeroes.

This isnt idle speculation - thing about BSD UFS fragments.

> anyway, I very much doubt it has any good properties to make software more
> complex by having that kind of readahead in sw.

Even the complex stuff like the i2o raid controllers seems to benefit
primarily from file level not physical readahead, that gives it enough to 
do intelligent scheduling and to keep the drive firmware busy making good
decisions (hopefully)

Even with software raid the physical readahead decisions belong in the raid
code as they are tied to strip alignment and sizes not high level policy

Alan
