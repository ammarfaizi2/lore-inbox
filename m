Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUEXS7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUEXS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUEXS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:59:25 -0400
Received: from 1002-19.lowesthosting.com ([216.127.84.7]:59109 "HELO
	1002-19.lowesthosting.com") by vger.kernel.org with SMTP
	id S263937AbUEXS7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:59:23 -0400
Date: Mon, 24 May 2004 13:58:50 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: "shanthi kiran pendyala" <skiranp@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mmap problem (VM_DENYWRITE)
Message-Id: <20040524135850.31ac9e62.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <000a01c441bf$ccb83600$322147ab@amer.cisco.com>
References: <20040519062044.15651.qmail@web90107.mail.scd.yahoo.com>
	<000a01c441bf$ccb83600$322147ab@amer.cisco.com>
X-Mailer: Sylpheed version 0.9.10cvs7 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_13_58_50_-0500_gZFL.BsIywMYTfT1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_13_58_50_-0500_gZFL.BsIywMYTfT1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Uttered "shanthi kiran pendyala" <skiranp@cisco.com>, spake thus:

> After mmaping in userspace any writes to the mmap region is not working. 
> I think it is b'cos of the protection field in the vma is set to
> VM_DENYWRITE. 
> The complete prot flag is (VM_READ | VM_WRITE | VM_EXEC | VM_GROWSUP |
> VM_DENYWRITE)
> 
> Why is this happening? I need to have both read and write access to region.
> How do I fix this ?

Take out the VM_DENYWRITE flag. Duh.

Are you gonna put code in the mapped area?  No? Turn off VM_EXEC.

Are you gonna place your stack in the mapped area?  No? Turn of
VM_GROWSUP.

Have you read "man mmap"?  No? Try it.

Cheers!

--Signature=_Mon__24_May_2004_13_58_50_-0500_gZFL.BsIywMYTfT1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAskXu/0ydqkQDlQERAglOAKCCntFmT+OGfTMMzw+8jKfrtuJmuQCbBrFW
FJMo9amPnNEginGLrPy9Tgo=
=xtRm
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_13_58_50_-0500_gZFL.BsIywMYTfT1--
