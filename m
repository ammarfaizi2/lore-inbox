Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEDRLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEDRLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVEDRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:08:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11276 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261251AbVEDRIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:08:09 -0400
Message-Id: <200505041708.j44H80lR016289@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Deepak <deepakgaur@fastmail.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hanged/Hunged process in Linux 
In-Reply-To: Your message of "Wed, 04 May 2005 14:38:48 +0900."
             <1115185128.12535.233322099@webmail.messagingengine.com> 
From: Valdis.Kletnieks@vt.edu
References: <1115185128.12535.233322099@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115226479_4721P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 13:08:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115226479_4721P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 May 2005 14:38:48 +0900, Deepak said:
> I am working on a Linux based system and developing a monitoring process
> which shall do the following function

> Anybody having another definition for a "Hanged process" in Linux
> context

Around here, the big issue is usually a process stuck in 'D' state - in
other words, a process that's done a syscall or otherwise entered the
kernel (page faults and AIO being other possibilities) and hasn't returned.
Since signals are delivered at return time, even a 'kill -9' wont do the
desired thing.  These are almost always the result of either kernel bugs
or hardware failures.

There was a lengthy thread a while ago about how to deal with these, and the
consensus was that there's *NO* good general way to un-wedge such a process,
and that fixing the underlying bug or hardware fault is the only way to deal
with it.

--==_Exmh_1115226479_4721P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCeQFvcC3lWbTT17ARAmGUAKDxLax6U1n+ENwKZKYS6/TPoFdRhgCg3q6z
ia04Qu/3ql9mTzQXnnceqrE=
=8pEM
-----END PGP SIGNATURE-----

--==_Exmh_1115226479_4721P--
