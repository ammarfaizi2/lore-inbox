Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUEPMMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUEPMMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 08:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUEPMMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 08:12:54 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:51982 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S263585AbUEPMMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 08:12:51 -0400
In-Reply-To: <20040516034847.GA5774@taniwha.stupidest.org>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com> <20040512213913.GA16658@fieldses.org> <jevfj1nwe1.fsf@sykes.suse.de> <20040516034847.GA5774@taniwha.stupidest.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-65--971975887"
Message-Id: <F812066A-A731-11D8-BD91-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Davide Libenzi <davidel@xmailserver.org>,
       Netdev <netdev@oss.sgi.com>, Jeff Garzik <jgarzik@pobox.com>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Greg KH <greg@kroah.com>
From: Paul Wagland <paul@wagland.net>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Date: Sun, 16 May 2004 14:10:06 +0200
To: Chris Wedgwood <cw@f00f.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-65--971975887
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On May 16, 2004, at 5:48, Chris Wedgwood wrote:

> On Wed, May 12, 2004 at 11:55:18PM +0200, Andreas Schwab wrote:
>
>> Signed integer overflow is undefined in C, so the compiler is
>> allowed to assume it does not happen.
>
> Really?
>
> Just because something is undefined assuming it never happens is a bit
> of a leap of faith IMO.

More precisely, if something has undefined semantics then the compiler 
is allowed to do whatever it likes. Normally the compiler will try to 
do "what's right", but if they have an optimisation opportunity then 
they will normally take it.

In other words by assuming it "doesn't happen" they get to perform an 
optimisation that they could not do otherwise, and they get to perform 
"correctly" in an undefined way when the overflow would happen.

Cheers,
Paul

--Apple-Mail-65--971975887
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAp1oftch0EvEFvxURAjQHAKCtnHclFM/KKANPRZzRRzFTe6xp3ACgompl
RJos9ShkK+bWPqs/guUZhAY=
=fkYG
-----END PGP SIGNATURE-----

--Apple-Mail-65--971975887--

