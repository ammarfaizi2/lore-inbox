Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVBQHRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVBQHRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVBQHRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:17:40 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:1400 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262247AbVBQHRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:17:35 -0500
Message-ID: <4214450B.6090006@triplehelix.org>
Date: Wed, 16 Feb 2005 23:17:31 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: 2.6.10: irq 12 nobody cared!
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE62FFE3B43E4B87C74D5152E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE62FFE3B43E4B87C74D5152E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Just migrated to 2.6.10 on an old VIA MVP3 box and I'm getting this:

irq 12: nobody cared!
  [<c012bb42>] __report_bad_irq+0x22/0x80
  [<c012bc0c>] note_interrupt+0x4c/0x80
  [<c012b6f8>] __do_IRQ+0x118/0x140
  [<c0103d76>] do_IRQ+0x36/0x60
  =======================
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c0117730>] __do_softirq+0x30/0xa0
  [<c0103e79>] do_softirq+0x39/0x40
  =======================
  [<c012b574>] irq_exit+0x34/0x40
  [<c0103d7d>] do_IRQ+0x3d/0x60
  [<c010271a>] common_interrupt+0x1a/0x20
  [<c012b914>] setup_irq+0x94/0x120
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c012baf2>] request_irq+0x72/0xa0
  [<c03ab9a1>] i8042_check_aux+0x21/0x140
  [<c01f20a0>] i8042_interrupt+0x0/0x180
  [<c03abe78>] i8042_init+0xf8/0x180
  [<c039c80b>] do_initcalls+0x2b/0xc0
  [<c0100440>] init+0x0/0xe0
  [<c0100467>] init+0x27/0xe0
  [<c010084d>] kernel_thread_helper+0x5/0x18
handlers:
[<c01f20a0>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12

Once the system is running, /proc/interrupts shows

            CPU0
   0:    1073809          XT-PIC  timer
   1:       1291          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   4:          7          XT-PIC  serial
   5:       4366          XT-PIC  eth0
   7:         12          XT-PIC  parport0
   8:          1          XT-PIC  rtc
  10:       7698          XT-PIC  uhci_hcd, uhci_hcd, eth1
  11:      58320          XT-PIC  ide2, ide3
  12:     306731          XT-PIC  wifi0
  14:      24446          XT-PIC  ide0
  15:         13          XT-PIC  ide1
NMI:          0
ERR:          0

that IRQ 12 is a wireless device:

0000:00:09.0 Network controller: Intersil Corporation Prism 2.5 Wavelan
chipset (rev 01)

that gets handled by HostAP. The device is operating correctly.

What's to blame here?

Thanks,

--
Joshua Kwan

--------------enigE62FFE3B43E4B87C74D5152E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQhRFDaOILr94RG8mAQKh3w/8CHD8gB3hv7pVsy0fA1y2IYpUVziFlH3w
kzukl/H7Y3UIBkAX7UCFdYd38hfEa+kNAD2opoon8wGDhEJuokRvf6wCEniRKWJV
z6ik5BzjuPYbrVlCv2Auf4SHB4yGp5oWZ63vbtcSTh1Bdh70vNZcWNLrRRiiEibj
ylZaTD6hZSD+J6Qw72jjU8jac3QE+gtkawU4L8/zO3sJv2XkccZ33pTykIjNeuFK
ieKWL8h0K6GslF6rxBc+Vnh/5QdZfxL2hx6kxwzjKdMHZ/3N6yeBJNlmhoex0CGC
yGXTljbHygTS/NboqTEKunHIFi6o5SLHhszdZFmYyp5iwuvbaJgoCupm9vGw4ZQa
8DZxcllvNlTIR9mxFof9U4tAoSpbOQE0+vWPYDwObY4fa+aRFGeAS4dwd6wOq+Sc
h7n9leS7mbIOWwt4wLMpT75oJ0xq1BKiJMmdBaoBKwRmkO8DwEZsxsWVo163SSmK
YWkLYHzTnOcGwNIpoloucvcvhDBC+V7y6rPTt4+DstOyMkjhnqktzQDLzZiigKUc
kb5VQHQ1m0iNFEkZasTsrpI67rwF87ZEOdYlxXlMvq8eTB0icdirhVroj0ASsd70
fHMk+ClteDoR6luVC9PuXq1l4w/YAXQA7plCPAXemtFF4I3tRTVfvseo95Z5I/xF
1T0hf35XsEg=
=vyVf
-----END PGP SIGNATURE-----

--------------enigE62FFE3B43E4B87C74D5152E--
