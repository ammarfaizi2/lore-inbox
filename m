Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSA3P6q>; Wed, 30 Jan 2002 10:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSA3P6g>; Wed, 30 Jan 2002 10:58:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33810 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289339AbSA3P6b>; Wed, 30 Jan 2002 10:58:31 -0500
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
To: michelpereira@uol.com.br (Michel Angelo da Silva Pereira)
Date: Wed, 30 Jan 2002 15:28:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020130113337.A2140@josephine.e-mail4you.com.br> from "Michel Angelo da Silva Pereira" at Jan 30, 2002 11:33:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VwfU-0007Xu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan 30 10:33:23 servmail kernel: i2o_scsi.c: Version 0.0.1
> Jan 30 10:33:23 servmail kernel:   chain_pool: 2048 bytes @ f6b92800
> Jan 30 10:33:23 servmail kernel:   (512 byte buffers X 4 can_queue X 1 =
> i2o controllers)
> Jan 30 10:33:23 servmail kernel: scsi2 : i2o/iop0

Ok the oops is not nice. The timeouts point to i2o_scsi and/or the serveraid
in i2o mode not liking one another (it has an official native mode driver
too btw which is the one you wanted)

Can you run the oops through ksymoops so I can see what the symbols are
and I'll take a look. I guess Im mixing a bus/host address somewhere on
the reset command (which just doesnt occur in normal i2o use)
