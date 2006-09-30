Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWI3U3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWI3U3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWI3U3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:29:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5538 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751935AbWI3U3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:29:22 -0400
Subject: Re: 2.6.18-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Matthew Wilcox <matthew@wil.cx>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <1159629982.14918.4.camel@mulgrave.il.steeleye.com>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159629982.14918.4.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Sep 2006 21:54:19 +0100
Message-Id: <1159649659.13029.149.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-30 am 10:26 -0500, ysgrifennodd James Bottomley:
> On Fri, 2006-09-29 at 23:50 +0000, Frederik Deweerdt wrote:
> > +       if (!pdev->irq)
> > +               return -ENODEV;
> > +
> 
> Don't I remember that 0 is a valid IRQ on some platforms?
> 
> i.e. shouldn't this be
> 
> if (pdev->irq == NO_IRQ)
> 	return -ENODEV;

NO_IRQ is gone. Everyone uses zero and Linus has declared that is how it
shall be.


Alan

