Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQKSTzq>; Sun, 19 Nov 2000 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQKSTzg>; Sun, 19 Nov 2000 14:55:36 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:60173 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S129416AbQKSTz0> convert rfc822-to-8bit; Sun, 19 Nov 2000 14:55:26 -0500
Date: Sun, 19 Nov 2000 20:03:52 +0100 (CET)
From: Gerd Knorr <kraxel@bytesex.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5 
In-Reply-To: <7411.974641779@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0011191956060.1015-100000@bogomips.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Keith Owens wrote:

> On 19 Nov 2000 12:56:17 GMT, 
> kraxel@bytesex.org (Gerd Knorr) wrote:
> >Some generic way to make module args available as kernel args too
> >would be nice.  Or at least some simple one-liner I could put next to
> >the MODULE_PARM() macro...
> 
> On my list for 2.5.  If foo is declared as MODULE_PARM in object bar
> then you will be able to boot with bar.foo=27 or even foo=27 as long as
> variable foo is unique amongst all objects in the kernel.

Cool.  Any plans how to handle drivers which are build from multiple
object files like bttv?  Think "bar" needs to be configurable handle this
nicely.  bttv should have bttv.card=xxx because the module is called
"bttv", but the source file where the card insmod option is declared is
bttv-cards.c ...

  Gerd

-- 
Wirtschaftsinformatiker == Leute, die zwar die aktuellen Aktienkurse
jedes Softwareherstellers kennen, aber keines der Produkte auch nur
ansatzweise bedienen können.		-- Benedict Mangelsdorff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
