Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266459AbRGHIX4>; Sun, 8 Jul 2001 04:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbRGHIXq>; Sun, 8 Jul 2001 04:23:46 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:14859 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266459AbRGHIXh>; Sun, 8 Jul 2001 04:23:37 -0400
Date: Sun, 8 Jul 2001 10:23:23 +0200
From: Joern Heissler <joern@heissler.de>
To: linux-kernel@vger.kernel.org
Subject: ide cdrom drive doesn't unlock in a special case
Message-ID: <20010708102323.A17851@debian.heissler.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!
I'm having problems with my cdrom-drive:
When I access the drive ("cat /dev/cdrom > /dev/null"), the tray is locked.

joern:/# cat /dev/cdrom > /dev/zero
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: ATAPI reset complete
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: ATAPI reset complete
end_request: I/O error, dev 16:40 (hdd), sector 42016
cat: /dev/cdrom: Input/output error
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: ATAPI reset complete
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34
hdd: ATAPI reset complete
end_request: I/O error, dev 16:40 (hdd), sector 42020
joern:/#

For some reason, my cdrom drive keeps being locked.
When I press ctrl-c before cat exits, the drive is unlocked.

I can reproduce it with 2.2.19, 2.4.6-ac2 and 2.4.5-ac13.
When using 2.2.0, the tray is unlocked.

My cdrom-drive is (according to system-bootup):
hdd: CD-524EA-B, ATAPI CD/DVD-ROM drive


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtIGHsACgkQs5jrxlfHa2bbzgCfa6IDQa5AjlRQcwHGnhfnjsoM
AtAAn2vdYQfpkRqt3BkQM+YfBvshy5vo
=KKod
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
