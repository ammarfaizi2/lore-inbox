Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUAAJf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAAJf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:35:56 -0500
Received: from derbian.org ([213.139.167.3]:31364 "EHLO mail.derbian.org")
	by vger.kernel.org with ESMTP id S265343AbUAAJfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:35:55 -0500
Date: Thu, 1 Jan 2004 09:35:53 +0000
From: Joonas Kortesalmi <joneskoo@derbian.org>
To: linux-kernel@vger.kernel.org
Subject: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101093553.GA24788@derbian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After running 2.6.0 on a server for a few days, I met an interesting and
annoying problem. I was playing with NFS over gigabit ethernet (e1000) and
it was a bit slow. I tried to find out why by running top and I saw syslog-ng
eating almost 10% of the 1,3GHz Duron. Looked at the log and there was a huge
flood of these messages:

swapper: page allocation failure. order:3, mode:0x20
irssi: page allocation failure. order:3, mode:0x20
swapper: page allocation failure. order:3, mode:0x20
vim: page allocation failure. order:3, mode:0x20
swapper: page allocation failure. order:3, mode:0x20

most of the messages starting with swapper.

After a quick google search it looks like this kind of a problem existed in
a bit older 2.5/2.6 serie kernels. It looks like it's still with us.

Linux hamsu.org 2.6.0 #1 Mon Dec 29 21:07:28 EET 2003 i686 AMD Duron(tm) processor AuthenticAMD GNU/Linux

Shortly about the hardware of the machine in case it would matter:
AMD Duron 1,3GHz CPU, 768MB of RAM, Intel PRO/1000MT Desktop and Realtek 8139C
NICs.

Pre-empt was disabled in the kernel config and the kernel didn't have any
extra patches. A pure vanilla kernel.

I'm not a subscriber so please CC me a copy of messages related to the subject.
I'm not sure if I can help much looking at the insides of the kernel, but I will
try my best answering any questions about this.
- -- 
Joonas  OH8GDV (ham call sign)   OpenPGP: 0x5F72BE43
( 0B37 05E0 0FB4 EB2E 161C  DCE6 7F7B C645 5F72 BE43 )
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/8+lzf3vGRV9yvkMRAgkIAJ4tjyWtfeDmXCaM0s6w9+ofYLKktACgt+I5
MhYxd+KeJS8QFOjPbtOmykk=
=75d0
-----END PGP SIGNATURE-----
