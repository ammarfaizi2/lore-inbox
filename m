Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTBVVbY>; Sat, 22 Feb 2003 16:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267922AbTBVVbY>; Sat, 22 Feb 2003 16:31:24 -0500
Received: from havoc.daloft.com ([64.213.145.173]:28866 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267921AbTBVVbX>;
	Sat, 22 Feb 2003 16:31:23 -0500
Date: Sat, 22 Feb 2003 16:41:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David Dillow <dave@thedillows.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: typhoon rx_copybreak
Message-ID: <20030222214128.GC27739@gtf.org>
References: <20030222.004504.113090900.davem@redhat.com> <3E57D54A.5FCDD811@thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E57D54A.5FCDD811@thedillows.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 02:53:46PM -0500, David Dillow wrote:
> Done. Pushed to 
> bk://typhoon.bkbits.net/typhoon-2.4
> bk://typhoon.bkbits.net/typhoon-2.5

I hope you don't mind my CC'ing lkml.  I think may be useful information
for others, as well.

For submitting net driver changes via BK, I would request what I request
of others using BK (and what Marcelo requests of me):

Send me a separate email with an easily noticable subject, something
like "[BK] typhoon net driver fixes/updates/whatever", including the
output of Documentation/BK-usage/bk-make-sum.  Typically this is done
like

	cd typhoon-2.4
	bk-make-sum ../linux-vanilla-2.4
	vi /tmp/linus.txt (fix URL, or whatever)
	email /tmp/linus.txt to me

then, additional email the broken-out GNU diffs for review.  Here is an
example, though there are several other ways to do this:

	cd typhoon-2.4
	bk changes -L ../linux-vanilla-2.4 2>&1 |	\
		perl csets-to-patches.pl
	# edit /tmp/rev-*.patch, and email, one per email

bk-make-sum and csets-to-patches are shipped in Documentation/BK-usage
in both 2.4.x and 2.5.x.

And, unless the 2.4 and 2.5 patches are 100.0000% the same, send patches
for both 2.4 and 2.5.

This spams me with a lot of email, but really does optimize the
submission process, and gets your updates into the mainline kernel very
quickly.  Ideally, I just have to do "read, read, read, cut-n-paste your
supplied bk pull URL"

Thanks and regards,

	Jeff



P.S. Nice work on the driver.  Even if technical issues are found, it's
very clean and easy to review and debug.
