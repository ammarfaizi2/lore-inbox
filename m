Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293021AbSBWALm>; Fri, 22 Feb 2002 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293052AbSBWALc>; Fri, 22 Feb 2002 19:11:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48905 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293021AbSBWALR>; Fri, 22 Feb 2002 19:11:17 -0500
Subject: Re: is CONFIG_PACKET_MMAP always a win?
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Sat, 23 Feb 2002 00:24:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        lk@tantalophile.demon.co.uk (Jamie Lokier), dank@kegel.com (Dan Kegel),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        zab@zabbo.net (Zach Brown)
In-Reply-To: <20020222214408.GI20060@matchmail.com> from "Mike Fedyk" at Feb 22, 2002 01:44:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ePzP-0003bi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > receiving source is free. Its certainly pretty close to free because the
> > overhead of sucking it into L1 cache will dominate and you need to do that
> > anyway.
> > 
> Doesn't DMA access system memory directly and leave processor caches alone?

It accesses system memory. That means the copy you have in cache is stale
so you need to get rid of the copy in the cache - be that software or
hardware.

