Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTBQMzq>; Mon, 17 Feb 2003 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBQMzq>; Mon, 17 Feb 2003 07:55:46 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30662 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267048AbTBQMzp>; Mon, 17 Feb 2003 07:55:45 -0500
Date: Mon, 17 Feb 2003 14:05:41 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: CRAMFS on Flash
Message-ID: <20030217130541.GA6282@wohnheim.fh-wedel.de>
References: <20030217122526.19514.qmail@webmail32.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030217122526.19514.qmail@webmail32.rediffmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 February 2003 12:25:26 -0000, Nandakumar  NarayanaSwamy wrote:
> 
> 1) Where to create the mtd partitions for the file system in 
> flash? First i just want to create a simple CRAMFS with some 
> binaries and executables and then mount it using mount command i.e 
> like
> mount -t cramfs /dev/mtdblock0 /home

Several options:
- Create a custom mapping driver with hard coded partitions, like most
  in drivers/mtd/maps.
- Use a partition table parser and put the partition table into flash.
- Look at the documentation to cmdline.c or browse through the mtd
  archives. (not sure, haven't looked at it myself yet)

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
