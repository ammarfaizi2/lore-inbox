Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUBTOps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUBTOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:45:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4356 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261252AbUBTOpm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:45:42 -0500
Message-Id: <200402192230.i1JMUifj004565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matthew Wilcox <willy@debian.org>
Cc: davidm@hpl.hp.com, torvalds@osdl.org, Michel D?nzer <michel@daenzer.net>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms 
In-Reply-To: Your message of "Wed, 18 Feb 2004 02:28:31 GMT."
             <20040218022831.GI11824@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <1077054385.2714.72.camel@thor.asgaard.local> <16434.36137.623311.751484@napali.hpl.hp.com> <1077055209.2712.80.camel@thor.asgaard.local> <16434.37025.840577.826949@napali.hpl.hp.com> <1077058106.2713.88.camel@thor.asgaard.local> <16434.41884.249541.156083@napali.hpl.hp.com> <20040217234848.GB22534@krispykreme> <16434.46860.429861.157242@napali.hpl.hp.com> <20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk> <16434.50928.682219.187846@napali.hpl.hp.com>
            <20040218022831.GI11824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1478586615P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Feb 2004 17:30:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1478586615P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 Feb 2004 02:28:31 GMT, Matthew Wilcox said:
> On Tue, Feb 17, 2004 at 05:59:12PM -0800, David Mosberger wrote:
> > I personally would be more than happy to reformat things to 80 cols,
> > but it's a waste of time unless almost all Linux code gets
> > reformatted.
> 
> Hm?  I don't know where you're getting that from.  Let's talk numbers.
> 
> Of the 60525 lines in .c files in arch/i386, 460 are longer than 80 cols.
> Of the 67398 lines in .c files in arch/ia64, 1189 are longer than 80 cols.
> Of the 496510 lines in .c files in drivers/net, 4044 are longer than 80 cols.

You apparently made the mistake of looking at character count < 80, not
lines that extend past column 80.

For 2.6.3-mm1, I see:
[/usr/src/linux-2.6.3-mm1/arch/i386]2 find . -name '*.c' | xargs cat | wc -l
  64542
[/usr/src/linux-2.6.3-mm1/arch/i386]2 find . -name '*.c' | xargs cat | awk 'length() > 80 { print $0}' | wc -l
    477
[/usr/src/linux-2.6.3-mm1/arch/i386]2 find . -name '*.c' | xargs cat |sed 's/\t/        /g'| awk 'length() > 80 { print $0}' | wc -l
   1291

(replace \t with whatever your shell needs to enter a literal tab .  Yes, this
botches on the relatively rare line that has an embedded tab. Deal with it. ;).

In other words, the situation is a lot worse if you count columns, not
characters.

(For IA64, it's 67,376 and either 1,185 or 3,222, and for drivers/net I see
493,027 and either 4,004 or 15,606 - ia64 is worse at the 80-col thing either way)


--==_Exmh_-1478586615P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFANTkTcC3lWbTT17ARAkIGAKC3AJIuHJek6tAm9DTUqLA8Oaj1YgCg33UM
jNhhp3RIWYPIyqTAtFEqHm0=
=M+0b
-----END PGP SIGNATURE-----

--==_Exmh_-1478586615P--
