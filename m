Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSA0Ofy>; Sun, 27 Jan 2002 09:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSA0Ofo>; Sun, 27 Jan 2002 09:35:44 -0500
Received: from mxzilla3.xs4all.nl ([194.109.6.49]:16651 "EHLO
	mxzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288028AbSA0Of3>; Sun, 27 Jan 2002 09:35:29 -0500
Date: Sun, 27 Jan 2002 15:35:28 +0100
From: thunder7 <thunder7@xs4all.nl>
To: Mark Zealey <mark@zealos.org>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
Message-ID: <20020127153528.A3222@xs4all.nl>
In-Reply-To: <20020127122501.GA23825@itsolve.co.uk> <000301c1a732$a989fa80$132f23d9@stratus> <20020127133348.GB23825@itsolve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020127133348.GB23825@itsolve.co.uk>; from mark@zealos.org on Sun, Jan 27, 2002 at 01:33:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 01:33:48PM +0000, Mark Zealey wrote:
> On Sun, Jan 27, 2002 at 01:00:57PM -0000, Daniel J Blueman wrote:
> 
> > Do you have a graphical console or text? I believe there are fixes in
> > 2.4.18-preX to decrease the 3dfx banshee/v3 pixel clock or something to
> > alleviate this issue. That'll be in the 3dfx framebuffer driver.
> > 
That fix only becomes active when the pixelclock is over half the maximum
value for the DAC on your card.
> > Or, of course, it could be something entirely different....
> 
> Text at something like 32x80 and graphics in X at 640x480. This seems to be a
> character map corruption problem, like an > will only have the / bit showing on
> it, or an ! will be half-sized etc. Also happens with other chars, but a flip
> back into X and then console again usially fixes it
> 
> -- 
That means it would be difficult to hit with the console at 80x32 and X at
640x480, unless you run at a ridiculous vertical frequency.
Anyway, it's simple to test if this fix caused it by replacing txfxfb.c 
with a version from before 2.4.18-pre6.

Since I proposed this fix, I'd be intertested to know if this fix caused it.

Let me know,
Jurriaan
> 
> Mark Zealey
> mark@zealos.org
> mark@itsolve.co.uk
> 
> UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
> !E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
> !R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--
> 
> (www.geekcode.com)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
