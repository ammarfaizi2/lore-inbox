Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281561AbRKMJg6>; Tue, 13 Nov 2001 04:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKMJgi>; Tue, 13 Nov 2001 04:36:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281561AbRKMJg0>; Tue, 13 Nov 2001 04:36:26 -0500
Subject: Re: Partitioning wierdness with 2048-byte sectors
To: andersen@codepoet.org
Date: Tue, 13 Nov 2001 09:43:29 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20011112235727.A6932@codepoet.org> from "Erik Andersen" at Nov 12, 2001 11:57:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163a6L-0000Z6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was just trying out 2.4.15-pre4 and noticed that I am
> completely unable to create partitions on my magneto optical
> drives (2048 byte hardware sectors).  Using fdisk to (try to)
> create a single partition uttery fails.  dmesg shows:
>     ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
>     sd.c:Bad block number requested I/O error: dev 08:10, sector 0

Looks like either Andrea's block device in page cache or the updated
partition code broke stuff. 
