Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTE2HDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTE2HDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:03:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261950AbTE2HDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:03:34 -0400
Date: Thu, 29 May 2003 00:15:19 -0700 (PDT)
Message-Id: <20030529.001519.27784970.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: zippel@linux-m68k.org, mika.penttila@kolumbus.fi, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529081315.A12513@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0305290151470.5042-100000@serv>
	<20030528.183700.104033543.davem@redhat.com>
	<20030529081315.A12513@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Thu, 29 May 2003 08:13:15 +0100
   
   Presumably then the two in drivers/block/rd.c (ramdisk_readpage and
   ramdisk_prepare_write) are out of spec then?

They are doing the page cache store, they are correct.

This also reminds me that we are missing calls in the
loop driver.
