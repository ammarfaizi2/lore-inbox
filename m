Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUFSBo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUFSBo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUFSBo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:44:27 -0400
Received: from mail.dif.dk ([193.138.115.101]:60593 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264934AbUFSBoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 21:44:25 -0400
Date: Sat, 19 Jun 2004 03:43:29 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
In-Reply-To: <pan.2004.06.19.01.23.34.471323@smurf.noris.de>
Message-ID: <Pine.LNX.4.56.0406190337110.17899@jjulnx.backbone.dif.dk>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
 <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org>
 <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk>
 <pan.2004.06.19.01.23.34.471323@smurf.noris.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Matthias Urlichs wrote:

> Hi, Jesper Juhl wrote:
>
> > [ printing control characters as "meaningful" C escapes ]
> > or am I not making sense?
>
> No, you're not. ;-)
>
Ok, I had a feeling that might be so. But I did not intend them to be
printed as '"meaningful" C escapes', I meant "why filter out \v or \f,
someone might find a clever use for them and they do no real harm
otherwhise"...


> Reason: They're not intended to be meaningful. If the kernel prints them,
> the reason isn't that somebody actually used an \a or \v in there, so
> doing that isn't helpful. (Quick, what's the ASCII for \v?)
>
What I meant was not for the kernel to attempt to print something like \a
, but it could be useful for it's original purpose of making a sound.. If
it's simply filtering out what goes to the screen (log, serial line,
whatever), but not preventing other uses, then my comments made no
sense... and 0x0B is \v I believe...


--
Jesper Juhl <juhl-lkml@dif.dk>

