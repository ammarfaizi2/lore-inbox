Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWI3QVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWI3QVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWI3QVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:21:43 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:22922 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751269AbWI3QVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:21:42 -0400
Date: Sat, 30 Sep 2006 10:21:41 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060930162141.GB16272@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159629982.14918.4.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159629982.14918.4.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 10:26:22AM -0500, James Bottomley wrote:
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
> 
> ?
> 
> I think this won't quite work because only the platforms that actually
> have a valid zero irq define it, but there must be something else that
> works.

Linus threw a hissy fit and declared that platforms which use 0 as a
valid IRQ are broken and wrong.  Despite PCI using 255 to mean no IRQ
and 0 as a valid IRQ ;-)
