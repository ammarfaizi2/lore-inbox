Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUKWXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUKWXPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKWXNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:13:04 -0500
Received: from mail.dif.dk ([193.138.115.101]:57822 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261546AbUKWXKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:10:12 -0500
Date: Wed, 24 Nov 2004 00:19:44 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <41A3C1AE.5060604@ammasso.com>
Message-ID: <Pine.LNX.4.61.0411240016350.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org> <41A38BF1.9060207@ammasso.com>
 <Pine.LNX.4.61.0411240003300.3389@dragon.hygekrogen.localhost>
 <41A3C1AE.5060604@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Timur Tabi wrote:

> Jesper Juhl wrote:
> 
> > if pid_t is 16 bit, then the value can never be greater than 0xffff but, if
> > pid_t is greater than 16 bit, say 32 bit, then the argument "a" could very
> > well contain a value greater than 0xffff and then the comparison makes
> > perfect sense.
> 
> If pid_t is 32-bit, then what's wrong with the value being greater than
> 0xFFFF?  After all, if pid_t a 32-bit number, that implies that 32-bit values
> are acceptable.
> 
My understanding of it is that it was just an example of how code that 
generated warnings about limited range of datatype could actually be 
perfectly fine.


--
Jesper Juhl

