Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbREUUAq>; Mon, 21 May 2001 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbREUUAg>; Mon, 21 May 2001 16:00:36 -0400
Received: from fungus.teststation.com ([212.32.186.211]:63185 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S262174AbREUUA1>; Mon, 21 May 2001 16:00:27 -0400
Date: Mon, 21 May 2001 22:00:07 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <Wayne.Brown@altec.com>, David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Background to the argument about CML2 design philosophy
In-Reply-To: <20010521135857.B11361@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0105212052290.13267-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Eric S. Raymond wrote:

> the NEW tag).  That phase ended almost a month ago.  Nobody who has
> actually tried the CML2 tools more recently has reported that the UI
> changes present any difficulty.

What happened with the discussion on configurable colors in make
menuconfig? Darkblue on black as frozen options get isn't exactly optimal
... at least not for my eyes. Being next to a bold, white text doesn't
help either.


> CML2 drops its configuration results in the same place, in the same
> formats, as CML1.  So you should in fact be able to type `make menuconfig'
> and `make oldconfig' with good results.  Have you actually tried this?

It works for me, but anyone testing this should know that the CML2 tools
read "config.out" if it finds one. So people that do things like:

make mrproper ; cp ../.config-2.4 .config ; make oldconfig

will have to change to copying config.out instead. Doing like this sort of
works* if there is no config.out, otherwise it does not (as it uses the
config.out).

Saying that the config result ends up in the same place and same format is
somewhat misleading, you do get a copy in the CML1 output format but the
tools doesn't care about that if it can find a file in the new format.

*) "Sort of works", since doing like I do will cause you to get a lot of
questions that you have already answered. That appears to be a one-time
problem as 'oldconfig' does not read "# CONFIG_FOO is not set" as "no".
Would be nice if it did.


make mrproper doesn't remove config.out. It should since that's what it
does with .config* files. Not sure if it should remove the rules.out file
also, but I think it should as the idea(?) with mrproper is to clean up
anything that is generated.

/Urban

