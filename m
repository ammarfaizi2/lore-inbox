Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRD3QJS>; Mon, 30 Apr 2001 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRD3QJH>; Mon, 30 Apr 2001 12:09:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132571AbRD3QI4>; Mon, 30 Apr 2001 12:08:56 -0400
Subject: Re: i2o_block struct gendisk misinitialization (2.4.3)
To: alvieboy@utad.pt (Alvaro Lopes)
Date: Mon, 30 Apr 2001 17:08:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox), alvieboy@alvie.com,
        herbert@debian.org (Herbert Xu)
In-Reply-To: <3AE9DB3A.7437F7B2@utad.pt> from "Alvaro Lopes" at Apr 27, 2001 09:48:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uGEI-0008GA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i2o_block is not properly initializing its gendisk structure
> (i2o_gendisk) and someone forgot to link it to the gendisk linked list,
> causing i2o hard drives and partitions not to show in /proc/partitions
> (debian installer relies on this to find fdisk'able drives).

This is the least of your worries. If you are using i2o use a -ac kernel
tree. There are a _lot_ of other things wrong with the base 2.4 tree and I've
not yet merged the fixes back. Many cards won't even work with the base 2.4
i2o


