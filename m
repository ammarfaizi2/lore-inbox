Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271653AbRH0FlV>; Mon, 27 Aug 2001 01:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271655AbRH0FlM>; Mon, 27 Aug 2001 01:41:12 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:28176 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S271653AbRH0Fk6>; Mon, 27 Aug 2001 01:40:58 -0400
Date: Mon, 27 Aug 2001 11:32:33 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Reg-filling of super_block in a filesystem
Message-ID: <Pine.LNX.4.10.10108271125080.20920-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In the minix_read_super() function we try to read a block number 1 from
the device. 

lock_super(s);
        set_blocksize(dev, BLOCK_SIZE);/*defined in fs/buffer.c*/
        if (!(bh = bread(dev,1,BLOCK_SIZE)))
                goto out_bad_sb;
        ms = (struct minix_super_block *) bh->b_data;
        

In the above, bh->b_data is assigned to ms. This minix_read_super function
gets called when we mount the minix file system. Then when does this block
1 of the device gets filled. Does it get filled when we do mkfs? Please
let me know this.

Thanks in advance.
Warm regards,
sathish.j

