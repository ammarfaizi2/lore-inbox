Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbRDUX6x>; Sat, 21 Apr 2001 19:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRDUX6n>; Sat, 21 Apr 2001 19:58:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133070AbRDUX6X>; Sat, 21 Apr 2001 19:58:23 -0400
Subject: Re: MO-Drive under 2.4.3
To: kobras@tat.physik.uni-tuebingen.de (Daniel Kobras)
Date: Sun, 22 Apr 2001 00:59:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010422013738.A520@pelks01.extern.uni-tuebingen.de> from "Daniel Kobras" at Apr 22, 2001 01:37:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r7I2-0004d8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) Put in lots of bigblock special case code in FAT;
> b) teach submit_bh() or generic_make_request() to transparently reblock 
>    bhs < hw_blksize and remove most special cases from FAT. Specifically,
>    it ought to stop pretending in sb->s_blocksize to use 2k blocks when
>    the fs is really tied to 512 byte blocks.
> 
> I tend to favour b), but which one is more likely to be accepted?

Al Viro suggested c) which was to transparently make it a loopback mount of
the raw device and let a loopback layer do the work.

