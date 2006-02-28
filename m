Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWB1WPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWB1WPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWB1WPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:15:13 -0500
Received: from host-84-9-202-199.bulldogdsl.com ([84.9.202.199]:2185 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750992AbWB1WPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:15:12 -0500
Date: Tue, 28 Feb 2006 22:12:43 +0000
From: Ben Dooks <ben-mtd@fluff.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make nand block functions use provided byte/word helpers.
Message-ID: <20060228221243.GC25880@home.fluff.org>
References: <20060228205903.GZ14749@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228205903.GZ14749@earth.li>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 08:59:03PM +0000, Jonathan McDowell wrote:
> Hi.
> 
> I've been writing a NAND driver for the flash on the Amstrad E3. One of
> the peculiarities of this device is that the write & read enable lines
> are on a latch, rather than strobed by the act of reading/writing from
> the data latch. As such I've got custom read_byte/write_byte functions
> defined. However the nand_*_buf functions in drivers/mtd/nand/nand_base.c
> are all appropriate, except for the fact they call readb/writeb
> themselves, instead of using this->read_byte or this->write_byte. The
> patch below changes them to use these functions, meaning a driver just
> needs to define read_byte and write_byte functions and gains all the
> nand_*_buf functions free.

Why not make life easier on everyone else by over-riding the
functions for read/write buffer (etc) in the nand driver... less
intrusive into the core code!

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
