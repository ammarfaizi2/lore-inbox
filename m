Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272554AbRH3X1Z>; Thu, 30 Aug 2001 19:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272555AbRH3X1P>; Thu, 30 Aug 2001 19:27:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272554AbRH3X07>; Thu, 30 Aug 2001 19:26:59 -0400
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
To: davem@redhat.com (David S. Miller)
Date: Fri, 31 Aug 2001 00:30:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, kraxel@bytesex.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010830.161453.130817352.davem@redhat.com> from "David S. Miller" at Aug 30, 2001 04:14:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cbGc-00027M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If mmap()'ing the frame buffer and passing this into read() is how
> this will be done, it simply won't work.  That's the point I'm trying
> to make.

That isnt done anyway - the card executes a risc instruction set for the
DMA engine specifying which to skip and draw. So you feed it a base
physical address for the fb via ioctl (yes this needs to be a pci device
bar and offset I suspect) and then tell it about the fb layout and the like
