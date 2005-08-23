Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVHWJ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVHWJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVHWJ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:26:35 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:19909 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S932105AbVHWJ0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:26:35 -0400
X-Remote-IP: 213.191.142.123
X-Remote-IP: 213.202.87.140
Date: Tue, 23 Aug 2005 11:26:07 +0200
From: Vid Strpic <vms@bofhlet.net>
To: ScytheBlade1 <scytheblade1@brantleyonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with MMC card reader
Message-ID: <20050823092607.GB21262@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	ScytheBlade1 <scytheblade1@brantleyonline.com>,
	linux-kernel@vger.kernel.org
References: <430AB13E.60609@brantleyonline.com>
In-Reply-To: <430AB13E.60609@brantleyonline.com>
X-Operating-System: Linux 2.6.11
X-Editor: VIM - Vi IMproved 6.3 (2004 June 7, compiled Jul 26 2005 23:22:01)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.10i
X-Sanitizer: This message has been sanitized!
X-Sanitizer-URL: http://mailtools.anomy.net/
X-Sanitizer-Rev: $Id: Sanitizer.pm,v 1.87 2004/05/07 17:42:12 bre Exp $
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEStream=_0+38467_738083332310736_0369353123"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MIMEStream=_0+38467_738083332310736_0369353123
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2005 at 11:16:46PM -0600, ScytheBlade1 wrote:
> I've enabled everything needed...the CF port works flawlessly. However,
> the SD slot does *not*. I've got about 5+ pages worth of dmesg output
> related to this (MMC is NOT debug enabled, and I still get a disturbing
> amount of output). Would here be the best place to post this, or would a
> different list be better? (Recommendations as to which list are welcomed
> :)).

CONFIG_SCSI_MULTI_LUN=3Dy

This is probably the answer you needed... because, the reader is a
single device, with multiple slots, and usb_storage driver uses SCSI
infrastructure, so multiple slots map to multiple SCSI LUN's.

Atleast, it worked for all my readers during the years :))

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.11 #1 Wed Mar 9 19:08:59 CET 2005 i686
 11:23:27 up 27 days,  3:56,  4 users,  load average: 0.11, 0.23, 0.29
We are Microsoft. First we'll reboot, and then asimilate you.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDCuuvq1AzG0/iPGMRAjl+AJ4iiJonSAj+z0Ba6/a9TjHTqZxmKgCglgAz
/G+WzolrpiV5kIkztxvuyao=
=vLv4
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
--MIMEStream=_0+38467_738083332310736_0369353123
Content-Type: text/sanitizer-log; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sanitizer.log"

This message has been 'sanitized'.  This means that potentially
dangerous content has been rewritten or removed.  The following
log describes which actions were taken.

Sanitizer (start="1124789169"):
  Forcing message to be multipart/mixed, to facilitate logging.


Anomy 0.0.0 : Sanitizer.pm
$Id: Sanitizer.pm,v 1.87 2004/05/07 17:42:12 bre Exp $

--MIMEStream=_0+38467_738083332310736_0369353123--
