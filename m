Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277183AbRKAA7y>; Wed, 31 Oct 2001 19:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRKAA7o>; Wed, 31 Oct 2001 19:59:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277072AbRKAA72>; Wed, 31 Oct 2001 19:59:28 -0500
Subject: Re: suspicious pci hang
To: stasko@phys.ufl.edu (John Stasko)
Date: Thu, 1 Nov 2001 01:06:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, madorsky@phys.ufl.edu (Alexander Madorsky)
In-Reply-To: <Pine.GSO.4.21.0110311930530.24268-100000@neptune.phys.ufl.edu> from "John Stasko" at Oct 31, 2001 07:53:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15z6Jk-0005hL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	x = inl(reg->bmsr);
> 
> The board is in a pci space.  I suspect the board simultaneously
> died some time around the upgrade or the perhaps the pci hardware
> implementation is not quite stable, or, maybe something changed in the
> kernel.
> 
> Yes, reg->bmsr contains a valid address (0x0000ec7c) and this value did
> not get "stomped on" since the PCI block was requested.  Further, I know

ec7c is in ram. That sounds like reg is a large object and reg = NULL
