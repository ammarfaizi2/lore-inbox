Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWBUDA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWBUDA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWBUDAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:00:25 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:10173 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161291AbWBUDAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:00:25 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 12:57:25 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220173608.GC33155@dspnet.fr.eu.org> <slrndvkp1m.326.andreashappe@localhost.localdomain>
In-Reply-To: <slrndvkp1m.326.andreashappe@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2233313.eLF32BOhHm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602211257.29161.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2233313.eLF32BOhHm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 21 February 2006 10:52, Andreas Happe wrote:

[...]

> I think that 'some people, like you' may be more than you think.
>
> I tried to use suspend2, but setup wasn't that great (i.e. didn't work
> as well or easy as swsusp) so I dropped it.

Could you provide more detail? If there's something I can do to make it eas=
ier=20
to use, I'm more than willing to consider that.

[...]

> Encryption and compression for non-timecritical tasks: User or
> kernelspace? The other stuff would be driver fixes (which would be
> accepted) or infrastructure changes (rafael is at least interested in
> bdev freezing, other stuff like using bitmaps seem totaly not acceptable
> (and weren't for rather long.. but nigel didn't seem to mind)).

I'm not sure I get what you're saying I didn't seem to mind.

Your comment about using bitmaps made me do some math to see how much I'm=20
saving by using them instead of Pavel's struct pbes. I don't think they wer=
e=20
commented on as 'totally unacceptable', but as I look at them again now, I'=
m=20
not so sure they're worth the effort. Will look again a little later in the=
=20
day, particularly at the flow on effects of making such a change - perhaps=
=20
I've forgotten something else).

(For the record, my thinking went: swsusp uses n (12?) bytes of meta data f=
or=20
every page you save, where as using bitmaps makes that much closer to a=20
constant value (a small variable amount for recording where the image will =
be=20
stored in extents). 12 bytes per page is 3MB/1GB. If swsusp was to add=20
support for multiple swap partitions or writing to files, those requirement=
s=20
might be closer to 5MB/GB. Bitmaps, in comparison, use ~32K/GB (approx=20
because it depends whether the gigabyte is all in one zone). Proportionally=
,=20
bitmaps are eating a lot less space out of your gigabyte, but I don't think=
=20
anyone is going to notice that they have 3 or 4MB more cache per gigabyte=20
with Suspend2 than they have with swsusp).

Regards,

Nigel

--nextPart2233313.eLF32BOhHm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+oGZN0y+n1M3mo0RAvp6AJ9zNnnH468sQsPA4zqUW7Wp9oWm/wCeO46L
Wc1TvLksqnvhwSbUNmTMV3E=
=i4mU
-----END PGP SIGNATURE-----

--nextPart2233313.eLF32BOhHm--
