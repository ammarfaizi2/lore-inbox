Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132705AbRDCV4g>; Tue, 3 Apr 2001 17:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132706AbRDCV41>; Tue, 3 Apr 2001 17:56:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132705AbRDCV4N>; Tue, 3 Apr 2001 17:56:13 -0400
Subject: Re: 2048 byte/sector problems with kernel 2.4
To: GTM.Kramer@inter.nl.net (Jurgen Kramer)
Date: Tue, 3 Apr 2001 22:58:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3ACA41D6.83718034@inter.nl.net> from "Jurgen Kramer" at Apr 03, 2001 11:34:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kYoO-0000Wy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MO disks which have normal 512 bytes/sector it all works flawlessly but
> as soon
> as a put in a 1.3GB disk which uses the 2048 bytes/sector format it all
> goes
> wrong. As soon as I write something to the disk by issuing a cp command

It will. Linux 2.4.x still hasn't had the scsi disk block size bugs fixed.
Stick to 2.2.19.

> I also tried it with 2.2.18 there it works but it seems to be utterly
> slow. I'm using kernel 2.4.2(XFS version to be precise).

M/O disks are slow. At a minimum make sure you are using a physical block size
of 2048 bytes when using 2048 byte media and plenty of memory to cache stuff
when reading. Seek times on M/O media are pretty poor

