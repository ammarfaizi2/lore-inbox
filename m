Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbRGXRwN>; Tue, 24 Jul 2001 13:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268398AbRGXRwD>; Tue, 24 Jul 2001 13:52:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268401AbRGXRvq>; Tue, 24 Jul 2001 13:51:46 -0400
Subject: Re: patch for allowing msdos/vfat nfs exports
To: nlaredo@transmeta.com (Nathan Laredo)
Date: Tue, 24 Jul 2001 18:51:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Nathan Laredo" at Jul 23, 2001 04:55:17 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15P6Ky-0000aT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> I've been using it for half a day now and so far it hasn't done
> anything bad, but please be careful if you decide to test it and
> backup your data and after testing, be sure to compare your data
> to your backup.

Rename ?

> +	struct inode *inode = dentry->d_inode;
> +	unsigned int i_pos = MSDOS_I(inode)->i_location;

i_location is not a constant across renames or other operations, so you may
inadvertantly do I/O to completely the wrong file


The infrastructure looks great, I just don't think your handles are safe 
