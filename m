Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVBXRGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVBXRGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVBXRGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:06:01 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:31451 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261735AbVBXRFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:05:46 -0500
Message-ID: <421E099F.1030104@free.fr>
Date: Thu, 24 Feb 2005 18:06:39 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <421D0582.9090100@free.fr> <20050223234720.GA7270@kroah.com>
In-Reply-To: <20050223234720.GA7270@kroah.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2F688E2FF64111ECAF9067E6"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F688E2FF64111ECAF9067E6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit



Le 24.02.2005 00:47, Greg KH a écrit :
> On Wed, Feb 23, 2005 at 11:36:50PM +0100, Laurent Riffard wrote:
>
>>hey, what's this /dev/hds ? digging into /sys/block...
>>
>>~$ ls -l  /sys/block/hds/device
>>lrwxrwxrwx  1 root root 0 f?v 23 22:45 /sys/block/hds/device ->
>>../../devices/pci0000:00/0000:00:04.1/ide1/1.1/
>>
>>/dev/hdq should be /dev/hdd...
>>
>>~$ ls -l /proc/ide
>>total 4
>>-r--r--r--  1 root root 0 f?v 23 23:28 drivers
>>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hda -> ide0/hda/
>>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdb -> ide0/hdb/
>>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdc -> ide1/hdc/
>>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdd -> ide1/hdd/
>>dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide0/
>>dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide1/
>>-r--r--r--  1 root root 0 f?v 23 23:28 via
>>~$ ls -d /sys/block/hd*
>>/sys/block/hda/  /sys/block/hdc/  /sys/block/hdq/  /sys/block/hds/
>
>
> What does /proc/devices show?

Character devices:
   1 mem
   4 /dev/vc/0
   4 tty
   5 /dev/tty
   5 /dev/console
   5 /dev/ptmx
   6 lp
   7 vcs
  10 misc
  13 input
  14 sound
  29 fb
116 alsa
128 ptm
136 pts
171 ieee1394
180 usb

Block devices:
   1 ramdisk
   2 fd
   3 ide0
   7 loop
  22 ide1
253 pktcdvd
254 device-mapper

Do you see something strange here  ?

--
laurent

--------------enig2F688E2FF64111ECAF9067E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCHgmfUqUFrirTu6IRAofXAKCA05JwI6+2l7cqHmx4TtxBMKfamwCfbUXf
GxKprZuexOMX6sgmhRrKQxg=
=8UG3
-----END PGP SIGNATURE-----

--------------enig2F688E2FF64111ECAF9067E6--
