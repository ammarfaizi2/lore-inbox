Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276509AbRI2O2i>; Sat, 29 Sep 2001 10:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276510AbRI2O22>; Sat, 29 Sep 2001 10:28:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276509AbRI2O20>; Sat, 29 Sep 2001 10:28:26 -0400
Subject: Re: 2.4.9-ac10 IDE access slows as uptime increases
To: tmwg-linuxknl@inxservices.com (George Garvey)
Date: Sat, 29 Sep 2001 15:33:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010928204612.A911@inxservices.com> from "George Garvey" at Sep 28, 2001 08:46:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nLB7-00027t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I've been noticing this for months, and thought I was crazy. But I
> just verified it.
>    I ran a program that's a GUI app/front-end to a data base, on the
> local drives. It took seconds to access a record.

Is the data base doing I/O directly to a block device and not using
O_DIRECT for one question

Second question is what is in your IDE logs. The IDE layer will change
down speeds when it hits a repeated problem (eg a DMA timeout) so if
need be will switch back to PIO or to MWDMA.

