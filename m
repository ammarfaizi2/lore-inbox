Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCRUQZ>; Mon, 18 Mar 2002 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSCRUQQ>; Mon, 18 Mar 2002 15:16:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291948AbSCRUQI>; Mon, 18 Mar 2002 15:16:08 -0500
Subject: Re: PCI drivers - memory mapped vs. I/O ports
To: EdV@macrolink.com (Ed Vance)
Date: Mon, 18 Mar 2002 20:32:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel')
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A7715@EXCHANGE> from "Ed Vance" at Mar 18, 2002 11:50:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16n3ne-0005xI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If a PCI device can be programmed equally well via I/O port space or memory
> space, what are the reasons to chose one space over the other when writing
> the driver?

mmio is posted on a PC i/o ports are not. That means you have to be more
careful but also means that

	write
	write
	write
	read

is a lot faster

