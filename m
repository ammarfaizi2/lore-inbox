Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUHBLyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUHBLyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHBLyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:54:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266482AbUHBLyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:54:47 -0400
Date: Mon, 2 Aug 2004 12:51:46 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
Message-ID: <20040802115146.GJ8175@redhat.com>
References: <20040730100421.GB8175@redhat.com> <410A4A1C.4040608@colorfullife.com> <20040730162023.GD8175@redhat.com> <410A7CBF.2020708@colorfullife.com> <20040730171606.GE8175@redhat.com> <410A8588.6020208@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WmFnK5hpO10R5Wg"
Content-Disposition: inline
In-Reply-To: <410A8588.6020208@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WmFnK5hpO10R5Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2004 at 07:29:44PM +0200, Manfred Spraul wrote:

> Could you try modprobe forcedeth;sleep 5;ip link set dev eth0 up.

Link was detected.

> Then=20
> pull out the network cable and check if the driver noticed that with=20
> ethtool.

It didn't.  It still thought there was a link.

> Plug in back in and check again. With dprintk enabled. Then=20
> send me the kernel log and the ethtool output.

Done: http://cyberelk.net/tim/tmp/debug.gz

> And add the lspci -vxx -s 00:05.0. Probably I'll make the timer=20
> dependant on nForce 1-3 and exclude the nForce 3 Gb nics: they don't=20
> need it.

# lspci -vxx -s 00:05.0
00:05.0 Ethernet controller: nVidia Corporation nForce3 Ethernet (rev a5)
        Subsystem: Asustek Computer, Inc.: Unknown device 80c5
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 10
        Memory at ff6fc000 (32-bit, non-prefetchable)
        I/O ports at eff0 [size=3D8]
        Capabilities: [44] Power Management version 2
00: de 10 d6 00 07 00 b0 00 a5 00 00 02 00 00 00 00
10: 00 c0 6f ff f1 ef 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c5 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 01 14

Thanks,
Tim.
*/

--6WmFnK5hpO10R5Wg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBDirS9gevn0C09XYRAlhKAJ9xlERZx8zN1TOL7BuKLUHbechMBACeOC64
qvic9Q1ZibGRwKe1qIveE+A=
=4eBu
-----END PGP SIGNATURE-----

--6WmFnK5hpO10R5Wg--
