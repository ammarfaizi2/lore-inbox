Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbUK3TOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbUK3TOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUK3TOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:14:24 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1937 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262247AbUK3TOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:14:18 -0500
Message-Id: <200411301914.iAUJEAJx001591@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Designing Another File System 
In-Reply-To: Your message of "Tue, 30 Nov 2004 17:46:10 GMT."
             <1101836768.25629.66.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <41ABF7C5.5070609@comcast.net> <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
            <1101836768.25629.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2134675488P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Nov 2004 14:14:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2134675488P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Nov 2004 17:46:10 GMT, Alan Cox said:
> On Maw, 2004-11-30 at 18:28, Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 29 Nov 2004 23:32:05 EST, John Richard Moser said:
> > they punt on the issue of over-writing a sector that's been re-allocated by
> > the hardware (apparently the chances of critical secret data being left in
> > a reallocated block but still actually readable are "low enough" not to wor
ry).
> 
> I guess they never consider CF cards which internally are log structured
> and for whom such erase operations are very close to pointless.

The 3-overwrites is for "rigid disks" only, and for "sanitize" operations
required when the media is being released from continuous protection (basically,
when you're disposing of the drive).  Clearing (for when the drive is being
kept, but re-used) only requires 1 pass.  A CF card would be handled
under different rules - I'm pretty sure it would be treated as the appropriate
class of "memory" (but admit not knowing which technology it would be).

See "Clearing and sanitization matrix" from the bottom of:
http://www.dss.mil/isec/chapter8.htm


--==_Exmh_2134675488P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBrMaCcC3lWbTT17ARArhjAKCIv3bFX5UQAi+ORuX8998koo45BwCgteBy
jlLqyjSJxdc8AQFVtJjU9Pg=
=lEFr
-----END PGP SIGNATURE-----

--==_Exmh_2134675488P--
