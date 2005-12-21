Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVLUA1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVLUA1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVLUA1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:27:45 -0500
Received: from smtp2.libero.it ([193.70.192.52]:56037 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S932143AbVLUA1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:27:45 -0500
From: borsa77@libero.it
To: Jesper Juhl <jesper.juhl@gmail.com>
Date: Wed, 21 Dec 2005 01:27:23 +0100
Subject: Re: [PATCH] Correction to kmod.c control loop
CC: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Message-ID: <43A8AF7B.3540.115294E@localhost>
In-reply-to: <9a8748490512201523o9430a9ew21135887202f2dbd@mail.gmail.com>
References: <9a8748490512201511v62153b33pfae22e512103552a@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (v4.11)
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Dec 2005 at 0:23, Jesper Juhl wrote:

> On 12/21/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > > > -       if (i > MAX_KMOD_CONCURRENT)
> > > > > +       if (i < MAX_KMOD_CONCURRENT)
> > > >
> > > > You changed MAX_KMOD_CONCURRENT from a constant to a variable above,
> > > > but you never assign a value to it, so here you are comparing i to an
> > > > uninitialized variable, not good.
> > >
> > >
> > > It is a _static_ local variable so it is assigned automatically to zero, I
> > > think.
> > >
> Hmm, yes, I wonder at that a bit as well, why static?

To maintain the value through a call of modprobe and a following one, 
so if the first fails you can maybe have the loading with the others.
