Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbULGXJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbULGXJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbULGXJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:09:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:49341 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261933AbULGXJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:09:52 -0500
Date: Wed, 8 Dec 2004 00:20:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee, Riina Kikas <riinak@ut.ee>
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed
In-Reply-To: <20041207010259.GA12352@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0412080016570.3320@dragon.hygekrogen.localhost>
References: <2C0CC42621D@vcnet.vc.cvut.cz> <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost>
 <20041207010259.GA12352@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Petr Vandrovec wrote:

> On Tue, Dec 07, 2004 at 12:09:05AM +0100, Jesper Juhl wrote:
> > On Mon, 6 Dec 2004, Petr Vandrovec wrote:
> > > Correct is (if any fix is needed at all) typecast regs->esp to unsigned
> > > long, 
> > 
> > That would have been my suggestion as well.
> > 
> > >eventually with check that address is less than (unsigned long)-32,
> > > as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
> > > nicely ask.
> > 
> > you mean something like this - right?
> 
> Yes.  Though I believe that we already take vma == NULL path when address is that big.

Hmm, where? - maybe I'm blind or just stupid, but I don't seem to be able 
to find where we do that.
And would it hurt to have that additional check there as well in case 
address was modified after the previous check and before being passed to 
do_page_fault ? (note: I'm writing this last bit without having mined the 
source for info yet).

-- 
Jesper


