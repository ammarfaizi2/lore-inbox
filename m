Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbUL1AFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUL1AFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUL1AFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 19:05:09 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:52101 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262005AbUL1AFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 19:05:03 -0500
Date: Tue, 28 Dec 2004 02:05:37 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: nico@cam.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add missing dependencies on MTD_PARTITIONS
Message-ID: <20041228000537.GB13807@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041227222348.GB13628@mellanox.co.il> <20041227225014.GD5345@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227225014.GD5345@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Adrian Bunk (bunk@stusta.de) "[2.6 patch] add missing dependencies on MTD_PARTITIONS":
> The patch below fixes them.
> 
> Please tell whether this fixes the problems you observed.

I have 2.6.10 so the patch didnt apply, with this reject:

***************
*** 198,204 ****

   config MTD_NAND_NANDSIM
        bool "Support for NAND Flash Simulator"
-       depends on MTD_NAND

        help
          The simulator may simulate verious NAND flash chips for the
--- 198,204 ----

   config MTD_NAND_NANDSIM
        bool "Support for NAND Flash Simulator"
+       depends on MTD_NAND && MTD_PARTITIONS

        help
          The simulator may simulate verious NAND flash chips for the


However, MTD_NAND_NANDSIM simply does not seem to be there in 2.6.10,
so thats probably ok.
Otherwise the problem is fixed.
I'd like to understand, why arent other map devices that seem to call
del_mtd_partitions, missing this symbol?

Thanks,
mst 
