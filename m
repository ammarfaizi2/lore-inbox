Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268451AbTCAEyx>; Fri, 28 Feb 2003 23:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268497AbTCAEyx>; Fri, 28 Feb 2003 23:54:53 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42374 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268451AbTCAEyw>; Fri, 28 Feb 2003 23:54:52 -0500
Date: Sat, 1 Mar 2003 00:05:12 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
In-Reply-To: <1046487638.21429.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0302282359320.2155-100000@marabou.research.att.com>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
 <1046487638.21429.0.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2003, Alan Cox wrote:

> On Sat, 2003-03-01 at 01:30, Pavel Roskin wrote:
> > In my opinion, the problem with IRQ routing on PCI-to-PCMCIA bridges is a
> > major problem that needs to be addressed in 2.4 series.  Linux
> > distributors who chose to use kernel PCMCIA (e.g. Red Hat) should be
> > interested in working PCMCIA support.  I cannot count how many times I
> > asked Red Hat users to recompile the kernel without PCMCIA support when
> > they wrote me about IRQ problems.
>
> Lets tyr it in -ac and see what cooks

Excellent!  By the way, please remove printk from my patch.  It turns out
that the socket is initialized more often than I expected (every time a
card is inserted), so it creates too much noise on the console.

I have tested a Ricoh bridge (Ricoh Co Ltd RL5c476 II), and it works
already, so let's not fix what is not broken, although I know what to do
if the IRQ problems are reported by someone else.

-- 
Regards,
Pavel Roskin
