Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTJSPzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTJSPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:55:52 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:35766 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261735AbTJSPz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:55:26 -0400
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>
Subject: Re: Blockbusting news, results are in
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
	<021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Oct 2003 17:55:09 +0200
In-Reply-To: <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
Message-ID: <m34qy5ql2a.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Norman Diamond" <ndiamond@wta.att.ne.jp> writes:

> 3.  If there were a way to enable reallocation in case of permanent errors,
> I think my friends would have said.  But they sure didn't say there were any
> user-settable options, they only said some approximations of how it was
> designed.

Other drives remap on write by default.

>  It does reallocations after temporary read errors but not after
> permanent read errors (where permanent means 255 failures in auto-retry).

Good so far.

> They think it does reallocations after temporary write errors, they weren't
> sure if it does reallocations after permanent write errors, now we know that
> it doesn't do reallocations after permanent write errors, and this is how it
> is designed, with no hint of options to toggle.

There isn't (shoudn't be) such a thing as "temporary" or "permanent"
write error. A write error should cause a sector to be remapped (the
question about how many times the drive should try to write a single
sector is irrelevant here). The drive should not return write error
unless all spare sectors are already in use (which means the drive
is approaching death and should be replaced immediately).

All drives I currently use do just that (though I don't currently use
Toshiba drives).

I would rather ask Toshiba if it's a bug in their firmware and if they
have fixed it. Or buy another brand.

> Why does RAM carry 6 year warranties?  (Maybe some don't but this is
> common.)

It doesn't have moving parts.

> > BTW, you're welcome to buy "premium" drives with 3-year or 5-year
> > warranties.  (3 on most vendor's high end ATA products, and 5 years on
> > most SCSI products)

We have that here (ATA, and I think all SCSI drives have 5 years).
Not sure about exact price increase, though.
-- 
Krzysztof Halasa, B*FH
