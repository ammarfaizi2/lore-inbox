Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUIFKs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUIFKs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 06:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUIFKs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 06:48:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:50624 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267518AbUIFKsz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 06:48:55 -0400
X-Authenticated: #7318305
Date: Mon, 6 Sep 2004 12:51:15 +0200
From: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: diablod3@gmail.com, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] r200 dri driver deadlocks
Message-Id: <20040906125115.0d49db62.felix@trabant>
In-Reply-To: <1094429682.29921.6.camel@krustophenia.net>
References: <d577e569040904021631344d2e@mail.gmail.com>
	<1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	<d577e56904090413365f5e223d@mail.gmail.com>
	<1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	<d577e56904090501224f252dbc@mail.gmail.com>
	<1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	<d577e569040905131870fa14a3@mail.gmail.com>
	<1094429682.29921.6.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 20:14:43 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Sun, 2004-09-05 at 16:18, Patrick McFarland wrote:
[snip]
> > 
> > That shouldn't matter, should it? The userland stuff should never lock
> > the machine up.
> > I'll test it anyhow, though.
> 
> No, it shouldn't.  Anything that directly accesses hardware belongs in
> the kernel.  How to fix this is a pretty hot topic now.

That's not the whole truth. There are just too many ways to lock up
those 3D chips. For instance I fixed a lockup in the r100 driver where
the order in which state changing commands were sent to the hardware
would cause a lockup. Each individual state changing command is
perfectly valid. Finding all permutations that trigger a lockup would
have been too much of a hassle and may not even have been true for all
supported hardware out there. So we made the user-space driver emit
state changing commands in a fixed order, which seems to work
everywhere.

Regars,
  Felix

> 
> Lee
> 

| Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
| PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
