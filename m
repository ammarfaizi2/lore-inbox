Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbQLDMgy>; Mon, 4 Dec 2000 07:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQLDMgo>; Mon, 4 Dec 2000 07:36:44 -0500
Received: from hera.cwi.nl ([192.16.191.1]:16375 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129614AbQLDMga>;
	Mon, 4 Dec 2000 07:36:30 -0500
Date: Mon, 4 Dec 2000 13:05:53 +0100
From: Andries Brouwer <aeb@veritas.com>
To: K Ratheesh <rathee@lantana.tenet.res.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux for local languages - patch
Message-ID: <20001204130553.A19985@veritas.com>
In-Reply-To: <Pine.LNX.4.10.10012040923020.29288-100000@lantana.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10012040923020.29288-100000@lantana.iitm.ernet.in>; from rathee@lantana.tenet.res.in on Mon, Dec 04, 2000 at 09:32:58AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 09:32:58AM +0530, K Ratheesh wrote:

> I am working on enabling Linux console for Local languages. As the current
> PSF format doesn't support variable width fonts , I have made a patch in
> the console driver so that it will load a user defined multi-glyph mapping
> table so that multiple glyphs can be displayed for a single character
> code. All editing operations will also be taken care of.

Good. Last year I needed support for Tibetan and added just the
converse: single glyphs that were represented by a sequence of
Unicode symbols. This is needed e.g. in the situation where Unicode
does not have precomposed symbol+diacritical, so that the glyph that
represents an accented character corresponds to a sequence rather
than a single Unicode symbol.

Did you start with this psf2 header (from kbd-1.03)?
(Last time I looked, console-tools didnt have this yet.)

> Further, for Indian languages, there are various consonant/vowel modifiers
> which result in complex character clusters. So I have extended the patch
> to load user defined context sensitive parse rules for glyphs /
> character codes as well. Again, all editing operations will behave
> according to the parse rule specifications.
> 
> Even though the patch has been developed keeping Indian languages in mind,
> I feel it will be applicable to many other languages (for eg. Chinese)
> which require wider fonts on console or user defined parsing at I/O level.

Yes, maybe. Or maybe something like this is better done in user space.

> Those who want to try out this patch can send mail to me in the address
> rathee@lantana.iitm.ernet.in or to indlinux-iitm@lantana.iitm.ernet.in 

Wouldnt mind seeing your patch.

Andries - aeb@cwi.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
