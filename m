Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbTCWRRf>; Sun, 23 Mar 2003 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbTCWRRf>; Sun, 23 Mar 2003 12:17:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41123
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263123AbTCWRRe>; Sun, 23 Mar 2003 12:17:34 -0500
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20030323145915.GA865@brodo.de>
References: <20030322140337.GA1193@brodo.de>
	 <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
	 <20030322162502.GA870@brodo.de>
	 <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
	 <20030323010338.GA886@brodo.de>
	 <1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
	 <20030323145915.GA865@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048444868.10729.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 18:41:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> printk("%4s\n", drive->name) prints out "hdd" all the time. 
> 
> hda is an ATA disk drive
> hdb is empty
> hdc is an ATAPI CD/DVD-ROM drive
> hdd is an ATAPI CD-ROM CD-R/RW drive

This gets weirder by the minute, and I still can't get it to happen here
annoyingly.  

The list thats breaking is a private list. We delete the drive from that
list, if its present (it may be an empty bay) we then use ata_attach 
to add it to a device list (or back to ata_unused). 

I find it hard to believe something like this is a compiler bug, but right
now I don't see how stuff is reappearing on the list.

