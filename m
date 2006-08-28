Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWH1ReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWH1ReG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWH1ReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:34:06 -0400
Received: from www.suchdol.net ([82.208.33.2]:14978 "EHLO www.suchdol.net")
	by vger.kernel.org with ESMTP id S1750859AbWH1ReF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:34:05 -0400
Date: Mon, 28 Aug 2006 19:34:01 +0200
From: Jindrich Makovicka <makovick@gmail.com>
To: David Masover <ninja@slaphack.com>
Cc: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
Message-ID: <20060828193401.5232e23c@holly.localdomain>
In-Reply-To: <44F16923.9050609@slaphack.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	<20060827010428.5c9d943b.akpm@osdl.org>
	<44F16923.9050609@slaphack.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 04:42:59 -0500
David Masover <ninja@slaphack.com> wrote:

> Andrew Morton wrote:
> > On Sun, 27 Aug 2006 04:34:26 +0400
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> >> The patch below is so-called reiser4 LZO compression plugin as
> >> extracted from 2.6.18-rc4-mm3.
> >>
> >> I think it is an unauditable piece of shit and thus should not
> >> enter mainline.
> > 
> > Like lib/inflate.c (and this new code should arguably be in lib/).
> > 
> > The problem is that if we clean this up, we've diverged very much
> > from the upstream implementation.  So taking in fixes and features
> > from upstream becomes harder and more error-prone.
> 
> Well, what kinds of changes have to happen?  I doubt upstream would
> care about moving some of it to lib/ -- and anyway, reiserfs-list is
> on the CC.  We are speaking of upstream in the third party in the
> presence of upstream, so...

The ifdef jungle is ugly, and especially the WIN / 16-bit DOS stuff is
completely useless here.

> Maybe just ask upstream?

I am not sure if Mr. Oberhumer still cares about LZO 1.x, AFAIK he now
develops a new compressor under a commercial license.

Regards,
-- 
Jindrich Makovicka
