Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291075AbSBLOYY>; Tue, 12 Feb 2002 09:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291079AbSBLOYQ>; Tue, 12 Feb 2002 09:24:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59915 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291075AbSBLOYH>; Tue, 12 Feb 2002 09:24:07 -0500
Subject: Re: File BlockSize
To: anish@bidorbuyindia.com (Anish Srivastava)
Date: Tue, 12 Feb 2002 14:37:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com> from "Anish Srivastava" at Feb 12, 2002 01:00:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ae3z-0001xO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way I can have 8K block sizes in ext2, reiserfs or ext3.

Buy an Alpha 8)

> I am trying to install Oracle on Linux with 8K DB_Block_size.
> But it gives me a Block size mismatch saying that the File BlockSize is only
> 4K
> 
> Maybe, there is a kernel patch available which enables Linux to create 8K
> file blocks.

With current kernels the maximum block size of a file system you can mount
is the page size of the architecture. Generally people limit to 4K to avoid
file systems that only work with some machines.

Going to a block size bigger than page size causes all sorts of fun with 
allocation failures if there are not two pages free adjacent to one another
when allocating, and isn't really worth the cost.

Alan
