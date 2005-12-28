Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVL1PP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVL1PP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVL1PP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:15:58 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:42089 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964832AbVL1PP5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:15:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZRT4Eaqg6ZXvoRttsDR5pEhoEqa/uDUj0MdAgqdsqkn46emZA3aqRaCv7A3/c8a5vy//HdIqQKPFZpk5ogpGTibrK66QW+Zu1ysip+JMNzq4XM6QKtqBeb9kPnBWVQHXQUJIxzaLSGdAN+aVlxXinKyCUg+mB5y192EXlCNrhs=
Message-ID: <84144f020512280715y61221ed0g381453cfd3c11c22@mail.gmail.com>
Date: Wed, 28 Dec 2005 17:15:54 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mathias Klein <ma_klein@gmx.de>
Subject: Re: oops in kernel 2.6.15-rc6
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051228145502.GB9777@sidney>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228135021.GA9777@sidney> <43B2A122.7030203@thinrope.net>
	 <20051228145502.GB9777@sidney>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/05, Mathias Klein <ma_klein@gmx.de> wrote:
> On Wed, Dec 28, 2005 at 11:28:50PM +0900, Kalin KOZHUHAROV wrote:
> > Mathias Klein wrote:
> > > Hello all,
> > >
> > > [please CC me on replies, I'm not subscribed to this list]
> > >
> > > I had this following kernel oops while compiling a new kernel.
> > >
> > > Dec 27 19:02:00 sidney kernel: [14896.995613] Unable to handle kernel paging request at virtual address 76f7104d
> > > Dec 27 19:02:00 sidney kernel: [14896.995665]  printing eip:
> > > Dec 27 19:02:00 sidney kernel: [14896.995682] c013a392
> > > Dec 27 19:02:00 sidney kernel: [14896.995692] *pde = 00000000
> > > Dec 27 19:02:00 sidney kernel: [14896.995711] Oops: 0002 [#1]
> >
> > I might be wrong, but that is the second oops for this run, probably the first [#0] is more
> > interesting...
>
> Probably yes but there is no [#0] Oops in the logs.
> (Indeed I do have another [#1] Oops in another run with that kernel without
> an [#0] Oops)

#1 is the first oops. See die() in arch/i386/kernel/traps.c. Anyway,
try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC to see if
they pick up anything.
