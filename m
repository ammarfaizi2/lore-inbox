Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290283AbSAOVeA>; Tue, 15 Jan 2002 16:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289686AbSAOVdv>; Tue, 15 Jan 2002 16:33:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290283AbSAOVdc>; Tue, 15 Jan 2002 16:33:32 -0500
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Tue, 15 Jan 2002 21:44:27 +0000 (GMT)
Cc: axboe@suse.de (Jens Axboe), andrea@suse.de (Andrea Arcangeli),
        jlbec@evilplan.org (Joel Becker),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <200201152123.g0FLN6K06540@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 15, 2002 01:23:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QbNb-0006K1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which can handle variable size IOs also. Isn't it ? Leaving it to
> the driver and doing variable size I/O on only the drivers that can 
> handle them, may be a better option ?

Given that almost all drivers can handle it possibly what is wanted in
the 2.5 case is something as simple as a library routine it can call
from the block I/O that converts variable sized I/O's.

That would meet your very sensible argument that it shouldn't be punishing
other drivers

Alan
