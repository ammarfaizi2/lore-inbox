Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267814AbRGUVHe>; Sat, 21 Jul 2001 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267825AbRGUVHZ>; Sat, 21 Jul 2001 17:07:25 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:38669
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S267814AbRGUVHQ>; Sat, 21 Jul 2001 17:07:16 -0400
Date: Sat, 21 Jul 2001 15:07:19 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Ole Gjerde <gjerdelist@icebox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 2100S and 2.4.7-pre8(and 2.4.6-ac5)  i2o driver
Message-ID: <20010721150718.A2638@zed.dlitz.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <026101c11045$455ec0b0$0b64a8c0@mimer.no>
User-Agent: Mutt/1.3.18i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2001 at 01:23:40PM +0200, Ole Gjerde wrote:
> Hi,
> I've been trying to get this Adaptec 2100S RAID card to work.  It works f=
ine
> with the adaptec patch(the dpt_i2o driver), but I would really like to get
> it to work with the stock i2o driver.  According to the messages I've seen
> so far this should work without any problems.
>=20
> However, when the kernel boots, it scans the bus, finds the card and star=
ts
> the initializing and then it oopses.
>=20

Are you using i2o_block or i2o_scsi?  i2o_scsi is broken, but some people
have gotten i2o_block to work.

Unfortunately, I'm also having problems with this card on a RAID1 array.
Basically, the install works fine, then if I run dselect update on Debian,
it'll get to Reading Package Lists...1%, then the drive freezes for several
seconds.  I get the following message, and the controller starts beeping
(because the array is "degraded"), and the OS continues to work normally
(albeit the ear-pearcing beeping).

/dev/i2o/hda error: Failure communicating to device.
end_request: I/O error, dev 50:09 (i2o block), sector 4416

Alan, if you're following this, do you have any ideas?

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtZ7wYACgkQ+Zi22OJyw8NJBACfbiPX6D7MOzQ3MBBPfO9FUlUd
Q+oAn0JvJ6GTc5ScIOINYQPopLVi31WO
=PPQO
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
