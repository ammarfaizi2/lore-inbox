Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTALXWw>; Sun, 12 Jan 2003 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTALXWw>; Sun, 12 Jan 2003 18:22:52 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:60896 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267643AbTALXWv> convert rfc822-to-8bit; Sun, 12 Jan 2003 18:22:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net, Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: any chance of 2.6.0-test*?
Date: Mon, 13 Jan 2003 00:31:24 +0100
User-Agent: KMail/1.4.3
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <20030112225228.GP31238@vitelus.com> <1042413101.3162.184.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042413101.3162.184.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130031.24169.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. Januar 2003 00:11 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 17:52, Aaron Lehmann wrote:
> > On Sun, Jan 12, 2003 at 05:34:58PM -0500, Rob Wilkens wrote:
> > > You're wrong.  You wouldn't have to jump over them any more than you
> > > have to jump over the "goto" statement.
> >
> > The goto is a conditional jump. You propose replacing it with a
> > conditional jump past the error handling code predicated on the
> > opposite condition. Where's the improvement?
>
> The goto is absolutely not a conditional jump.  The if that precedes it
> is conditional.  The goto is not.  The if is already there.

Oh, well.
Apologies first, my assembler is rusty.

if (a == NULL)
	goto err_out;

bad compiler ->
tst $D0 ; evaluate a == NULL
bne L1 ; this is the if
bra err_out ; this is the goto
L1:

good compiler ->
tst $D0
beq err_out ; obvious optimisation

	Oliver

