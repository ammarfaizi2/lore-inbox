Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUDAPWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUDAPWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:22:54 -0500
Received: from main.gmane.org ([80.91.224.249]:35270 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262580AbUDAPWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:22:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: 2.6 kernels misdetect harddisk geometry, 2.4 kernels are fine
Date: Thu, 1 Apr 2004 19:22:46 +0400
Message-ID: <20040401192246.00719d71.vsu@altlinux.ru>
References: <406C2AFB.1030101@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__1_Apr_2004_19_22_46_+0400_VTsMrAj/WO9Y4DHo"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mivlgu.ru
X-Newsreader: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__1_Apr_2004_19_22_46_+0400_VTsMrAj/WO9Y4DHo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 01 Apr 2004 16:45:15 +0200 Carl-Daniel Hailfinger wrote:

> the harddisk geometry recognized by 2.6 kernels differs from the geometry
> recognized by 2.4 kernels. The 2.4 kernel version agrees with the BIOS and
> fdisk/parted. The 2.6 kernel version seems senseless to me. Here is a diff
> between bootup messages: (more info available if you need it)
[skip]

In fact, this did not work correctly even in 2.4, except in some very
limited circumstances: either hda only, or hda+hdb.  Even hda+hdc
configuration was broken (hda was getting parameters from BIOS, but
hdc was not).

> You can see that both share the same sector count, but differing Megabytes
> and differing CHS. This breaks nearly every partitioning program I know
> and it makes supporting old ATARAID configurations a nightmare. (Some of
> the RAID superblock locations depend on the BIOS idea of CHS.)

Again, this was broken in 2.4.x too, except for the first IDE drive.
Difference in Megabytes is probably due to rounding and should not
matter (this is output only).

--Signature=_Thu__1_Apr_2004_19_22_46_+0400_VTsMrAj/WO9Y4DHo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbDPIW82GfkQfsqIRAnSjAJ4xklb+MrPPW8c15qM73fTl9/9vjQCdH2hi
xXHwYh7Y98CY6AMA0tJKhiU=
=WuQG
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Apr_2004_19_22_46_+0400_VTsMrAj/WO9Y4DHo--

