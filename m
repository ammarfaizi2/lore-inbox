Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266667AbRGOPeE>; Sun, 15 Jul 2001 11:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266662AbRGOPdz>; Sun, 15 Jul 2001 11:33:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59922 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266647AbRGOPdk>; Sun, 15 Jul 2001 11:33:40 -0400
Subject: Re: [PATCH] 64 bit scsi read/write
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 15 Jul 2001 16:32:59 +0100 (BST)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        andrewm@uow.edu.au (Andrew Morton),
        adilger@turbolinux.com (Andreas Dilger),
        acahalan@cs.uml.edu (Albert D. Cahalan), bcrl@redhat.com (Ben LaHaise),
        kernel@ragnark.vestdata.no (Ragnar Kjxrstad),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <20010716023911.A10576@weta.f00f.org> from "Chris Wedgwood" at Jul 16, 2001 02:39:11 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LntD-000489-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I only have SCSI disks to test with, but they are hot-plug, so I guess
> I can write a whole bunch of blocks with different numbers on them,
> all over the disk, if I can figure out how to place SCSI barriers and
> then pull the drive and see what gives?

Another way is to time

	write block
	write barrier
	write same block
	write barrier
	repeat

If the write barrier is working you should be able to measure the drive rpm 8)

