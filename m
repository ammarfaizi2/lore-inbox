Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAUUjL>; Sun, 21 Jan 2001 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAUUjB>; Sun, 21 Jan 2001 15:39:01 -0500
Received: from fungus.teststation.com ([212.32.186.211]:50376 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129413AbRAUUiv>; Sun, 21 Jan 2001 15:38:51 -0500
Date: Sun, 21 Jan 2001 21:38:26 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more via-rhine problems.
In-Reply-To: <Pine.LNX.4.31.0101181343550.824-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.30.0101211909030.11993-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Mike A. Harris wrote:

> I now believe that it is indeed caused by booting to windows 98
> (by accident).  ;o)

Don't do that then :)

> Doesn't matter if a driver is installed in win or not as I've
> tried both.  Just booting win at all causes the card to go
> berzerk next boot.  Must be something missing from the card init
> code that should be resetting something on the card at init time,
> but which is set by default on power on.

I can't reproduce this, but I only have a 1106:3043 (DFE-530TX revA1) and
tested this on a rather old P133.

I tested 2.2.19pre and not 2.2.18+becker1.08, the biggest difference is
the detection code so maybe that could be worth trying. 2.4 is again a
little bit different ...

You could try playing with bios settings. And dumping register contents
from a working and non-working setup, for example:

% via-diag -aaeemm
  (ftp://ftp.scyld.com/pub/diag/via-diag.c)

% lspci -vvxxx -d 1106:3065

Maybe CONFIG_PCI_QUIRKS helps?

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
