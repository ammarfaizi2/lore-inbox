Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135457AbRAUGlq>; Sun, 21 Jan 2001 01:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbRAUGlg>; Sun, 21 Jan 2001 01:41:36 -0500
Received: from quark.mcnc.org ([152.45.4.107]:59664 "EHLO quark.mcnc.org")
	by vger.kernel.org with ESMTP id <S135457AbRAUGl0>;
	Sun, 21 Jan 2001 01:41:26 -0500
Date: Sun, 21 Jan 2001 01:41:05 -0500 (EST)
From: Xiaoyong Wu <xwu@picard.mcnc.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.0 with 3c509 (patch included)
Message-ID: <Pine.LNX.4.30.0101210137230.23346-100000@quark.mcnc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
I have no trouble when I am using 2.2 with my 3c509 card but I can
not load the 3c509 with 2.4 kernel. After digging into the kernel source,
I figured out the problem.
Here's the diff:

421,422d420
<       request_region(ioaddr, EL3_IO_EXTENT, "3c509");
< /*
425d422
< */

Thanks.
- -Xiaoyong

- -----------------------------------
Network Research Engineer,                       919.248.1469
Advanced Network Research Group,MCNC             xwu@anr.mcnc.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpqhIUACgkQC2kI34vVezr8FwCbBaFRFiOtykAS9nZgDEoig4Mx
dwgAnjgxB96gbCb2FC6T6TkuiF2PPsbS
=fj/9
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
