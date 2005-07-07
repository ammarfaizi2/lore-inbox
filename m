Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVGGVV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVGGVV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGVTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:19:46 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:53608 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVGGVTH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:19:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wq9HNLUfXeC7LIdlW+ainy5yvZquR3xlq805G0FWpd0mWhTCxq8ZExa/obvnthiN69lwXv1emQKD9tqgdrSTuvYVPrP2gn6G3I2CDydTTWolG4HtpPlNrLL11CrpUwdd/rY/UeY6CHwWRrWL2RD2faE2sUu+CU8rr3ru4g9pZYM=
Message-ID: <58cb370e050707141913e87371@mail.gmail.com>
Date: Thu, 7 Jul 2005 23:19:04 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Cc: Christoph Lameter <christoph@lameter.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050707211505.GM21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706133052.GF21330@wotan.suse.de>
	 <Pine.LNX.4.62.0507070912140.27066@graphe.net>
	 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org>
	 <Pine.LNX.4.62.0507071022480.7105@graphe.net>
	 <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
	 <Pine.LNX.4.62.0507071208210.8200@graphe.net>
	 <20050707211505.GM21330@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/05, Andi Kleen <ak@suse.de> wrote:
> On Thu, Jul 07, 2005 at 12:09:00PM -0700, Christoph Lameter wrote:
> > On Thu, 7 Jul 2005, Linus Torvalds wrote:
> >
> > > Yes. Except that if hwif is NULL, we'll have other oopses since we access
> > > that in other places.
> > >
> > > Why _is_ hwif NULL anyway? That's another, unrelated thing, and should
> > > probably have a separate check and an early return.
> >
> > I was wondering about that one as well. Andi brought it up.
> 
> I don't know why hwif was NULL, but my kernel definitely crashed.
> hwif was NULL in the first function (I first misread the oops
> and thought it was pci_dev NULL, but it wasn't).  For the second
> I didn't verify it was hwif or pci_dev NULL, but one of them
> was too.
> 
> The setup was a Intel board with 1 PATA/4 SATA onboard and only a CD-ROM
> and a external Promise PATA controller with two PATA disks.

actual OOPS would be very useful
