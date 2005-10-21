Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVJUV3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVJUV3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVJUV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:29:20 -0400
Received: from CPE-61-9-212-151.qld.bigpond.net.au ([61.9.212.151]:10303 "EHLO
	bastard.youngs.au.com") by vger.kernel.org with ESMTP
	id S965173AbVJUV3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:29:19 -0400
From: Steve Youngs <steve@youngs.au.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.13.4 After increasing RAM, I'm getting Bad page state at prep_new_page
Keywords: page,new,memory,state,run,ram,hugh
Organization: Linux Users - Fanatics Dept.
References: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
	<Pine.LNX.4.61.0510191741350.8481@goblin.wat.veritas.com>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, steve@youngs.au.com
X-X-Day: Only 2430946 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Discordian-Date: Setting Orange, the 3rd day of The Aftermath, 3171. 
X-Attribution: SY
Date: Sat, 22 Oct 2005 07:29:11 +1000
In-Reply-To: <Pine.LNX.4.61.0510191741350.8481@goblin.wat.veritas.com> (Hugh
	Dickins's message of "Wed, 19 Oct 2005 17:59:33 +0100 (BST)")
Message-ID: <microsoft-free.87ll0mblug.fsf@youngs.au.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) SXEmacs/22.1.3 (BMW, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

* Hugh Dickins <hugh@veritas.com> writes:

  > On Thu, 20 Oct 2005, Steve Youngs wrote:
  >>=20
  >> A few days ago I increased my RAM from 0.5Gb to 3Gb and since then
  >> I've been getting `Bad page state at prep_new_page' errors at odd
  >> times.  Here is a typical backtrace from my logs:
  >>=20
  >> Bad page state at prep_new_page (in process 'X', page c1f7bde0)
  >> flags:0x80000004 mapping:00000000 mapcount:-262144 count:0

  > The bad memory in question (the struct page at 0xc1f7bde0) is quite
  > low down, just below 32MB.  Would I be right to guess that that you
  > inserted the new cards in such a way that the low memory is new RAM?

No.  All the memory is new RAM.  I originally had 2x256MB, and I
replaced those with 3x1GB.  Sorry if the Subject header was a bit
misleading.=20

  > I suggest you try taking out that lowest card, and see what happens
  > then.  Sometimes the kernel these days seems to find memory problems
  > that memtest86 does not (how long did you run it? overnight?).

When I had posted the message I had only let it run through all tests
once.  I have since let it run for about 18 hours, where it came up
with a single error (as reported in my reply to Ken).

  > You could try sending me all your "Bad page state" messages,
  > to check for correlations.

OK, I'll send those to you off-list.

Thanks very much, Hugh.

=2D-=20
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkNZXacACgkQHSfbS6lLMAM/MwCgzu3Ox0kdAZ067vjOTIh1MfkU
mZ0An1612u5MEwoXXaBOh4QadTJfbbvp
=nMQi
-----END PGP SIGNATURE-----
--=-=-=--
