Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRIRNAo>; Tue, 18 Sep 2001 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRIRNAd>; Tue, 18 Sep 2001 09:00:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271005AbRIRNAT>; Tue, 18 Sep 2001 09:00:19 -0400
Subject: Re: Module-loading problem with 4MB of ram
To: pasik@iki.fi (=?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?=)
Date: Tue, 18 Sep 2001 14:05:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109181217330.4235-100000@edu.joroinen.fi> from "=?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?=" at Sep 18, 2001 12:22:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jKYe-0000sT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ptr =3D dmalloc(size, GFP_ATOMIC);
> is there any way to reserve some memory for the driver-module?

Since its very unlikely the firmware is DMA transfered into the card (check
that obviously) I suspect using vmalloc/vfree instead of kmalloc/kfree will
do the trick
