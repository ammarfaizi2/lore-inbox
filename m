Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSAPAa1>; Tue, 15 Jan 2002 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289795AbSAPAaS>; Tue, 15 Jan 2002 19:30:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289793AbSAPAaH>; Tue, 15 Jan 2002 19:30:07 -0500
Date: Tue, 15 Jan 2002 16:29:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: John Weber <weber@nyc.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020115192048.G17477@redhat.com>
Message-ID: <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Benjamin LaHaise wrote:
>
> Hmm, this should fix that.

probably will, BUT..

> +#ifndef __ASM__ATOMIC_H
> +#include <asm/atomic.h>
> +#endif

Please do not assume knowdledge of what the different header files use to
define their re-entrancy.

Just do

	#include <asm/atomic.h>

and be done with it.

		Linus

