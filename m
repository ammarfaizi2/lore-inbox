Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291392AbSAaXMr>; Thu, 31 Jan 2002 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291393AbSAaXMh>; Thu, 31 Jan 2002 18:12:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291392AbSAaXMU>; Thu, 31 Jan 2002 18:12:20 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: davem@redhat.com (David S. Miller)
Date: Thu, 31 Jan 2002 23:24:10 +0000 (GMT)
Cc: vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> from "David S. Miller" at Jan 31, 2002 02:59:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WQYs-0003Ux-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a side note, this thing is so tiny (less than 4K on sparc64!) so
> why don't we just include it unconditionally instead of having all
> of this "turn it on for these drivers" stuff?

Because 100 4K drivers suddenly becomes 0.5Mb. There are those of us trying
to stuff Linux into embedded devices who if anything want more configuration
options not people taking stuff out.

What I'd much rather see if this is an issue is:

bool	'Do you want to customise for a very small system' 

which auto enables all the random small stuff if you say no, and goes
much deeper into options if you say yes.

Alan
