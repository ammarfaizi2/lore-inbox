Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131057AbRAOTnL>; Mon, 15 Jan 2001 14:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131100AbRAOTnD>; Mon, 15 Jan 2001 14:43:03 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:33798 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131057AbRAOTmt>;
	Mon, 15 Jan 2001 14:42:49 -0500
Message-ID: <20010115204254.B17484@win.tue.nl>
Date: Mon, 15 Jan 2001 20:42:54 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk geometry changed after running linux
In-Reply-To: <3A633EF6.44E5A2C@uni-mb.si> <20010115195131.A17484@win.tue.nl> <3A634777.48A41C82@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A634777.48A41C82@uni-mb.si>; from David Balazic on Mon, Jan 15, 2001 at 07:54:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 07:54:47PM +0100, David Balazic wrote:

> Is there a way to change the geometry from fdisk ?
> I tried expert mode and 'set sectors' and 'set heads',
> but after I exit fdisk with 'w' , it is unchanged.

As you know, a disk does not have a geometry, but
the location of a partition is described in linear
and 3D coordinates, and translating between the two
requires a geometry. Commands like
	% sfdisk -d /dev/hdf > hdf.pt
	% sfdisk /dev/hdf < hdf.pt
suffice to make the translation uniform for the
kernel's current idea of sectors, heads.
If you don't like that idea, then -C,-H,-S options
serve to tell sfdisk about the desired geometry.
See sfdisk(8).
[Save a copy of the old situation, and make the geometry so
that Windows likes it. Linux is happy with every geometry.]

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
