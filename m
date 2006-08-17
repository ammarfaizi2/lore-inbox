Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWHQOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWHQOsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWHQOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:48:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52109 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965082AbWHQOsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:48:31 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: 7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060817143633.GF13641@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz>
	 <1155821951.15195.85.camel@localhost.localdomain>
	 <20060817132309.GX13639@csclub.uwaterloo.ca>
	 <1155822530.15195.95.camel@localhost.localdomain>
	 <20060817143633.GF13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 16:09:17 +0100
Message-Id: <1155827358.15195.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 10:36 -0400, ysgrifennodd Lennart Sorensen:
> I think hal should get an error when it tries to open the cdrom device
> when the burning application is using it.  It shouldn't even get a

If it uses O_EXCL it will find the device busy assuming both parties use
O_EXCL properly.

> chance to issue an ioctl.  I was assuming hal doesn't keep the cdrom
> device open at all times (if it does, well that would be stupid).

Indeed but this is HAL so I suggest you strace it first 8)

