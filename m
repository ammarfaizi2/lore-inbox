Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTAJRAh>; Fri, 10 Jan 2003 12:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTAJRAh>; Fri, 10 Jan 2003 12:00:37 -0500
Received: from [81.2.122.30] ([81.2.122.30]:42246 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265275AbTAJRAf>;
	Fri, 10 Jan 2003 12:00:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301101708.h0AH8nUS013550@darkstar.example.net>
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 10 Jan 2003 17:08:49 +0000 (GMT)
Cc: ludovic.drolez@freealter.com, linux-kernel@vger.kernel.org
In-Reply-To: <1042218525.31848.40.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jan 10, 2003 05:08:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm trying to backup a partition on an IDE drive which has an odd number 
> > of sectors (204939). With a stock open/read you cannot access the last 
> > sector, and that why I tried the BLKBSZSET ioctl to set the basic read 
> > block size to 512 bytes. I verified the writen value with BLKBSZGET 
> > ioctl, but I still cannot read this last sector !
> 
> Its a known 2.4 limitation. The last odd sector isnt normally used by
> anything so it has never been a big issue (except with EFI partition
> data).

Didn't some really obscure IBM drives use it for something internally,
and shortly after everybody else had to stop using it incase they
overwrote the custom data at the end of an IBM disk, or am I thinking
of something else?

John.
