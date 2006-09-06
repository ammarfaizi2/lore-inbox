Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWIFIZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWIFIZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIFIZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:25:26 -0400
Received: from cernmx05.cern.ch ([137.138.166.161]:59538 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1750786AbWIFIZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:25:24 -0400
Keywords: CERN SpamKiller Note: -49 Charset: west-latin
X-Filter: CERNMX05 CERN MX v2.0 060718.1314 Release
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-21-982772760"
Message-Id: <E5DA3895-7CFB-47BB-A6B3-D9F073F9F5A3@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: question about __raw_spin_lock()
Date: Wed, 6 Sep 2006 10:25:15 +0200
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
X-OriginalArrivalTime: 06 Sep 2006 08:25:20.0374 (UTC) FILETIME=[FDB52960:01C6D18D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-21-982772760
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Dear experts!

Trying to inform myself about the locking possibilities on i386, I  
read linux/include/asm-i386/spinlock.h. I'm no expert on inline  
assembly, so I'm asking myself what would happen on a very big system  
if more than 128 threads are waiting on the same raw_spinlock_t.  
Would the 129th locker erroneously succeed immediately?

As a side note: I was looking because I have to implement a simple  
lock between processes in shared memory, and unfortunately I cannot  
use the NPTL :-( SysV semaphores presumably are much too heavy to  
protect simple linked list operations (no scanning of the list under  
the lock, just inserting on one end and removing from the other).  
Does anybody have a better idea than spinning in user space---with a  
nanosleep now and then---or does this have problems I'm not aware of?

Thanks for your help,

                     Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str., 85748 Garching
Telefon 089/289-12575; Telefax 089/289-12570
--
CERN office: 892-1-D23 phone: +41 22 7676540 mobile: +41 76 487 4482
--
Any society that would give up a little liberty to gain a little
security will deserve neither and lose both.  - Benjamin Franklin
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/CS/M/MU d-(++) s:+ a-> C+++ UL++++ P+++ L+++ E(+) W+ !N K- w--- M 
+ !V Y+
PGP++ t+(++) 5 R+ tv-- b+ DI++ e+++>++++ h---- y+++
------END GEEK CODE BLOCK------



--Apple-Mail-21-982772760
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFE/oXvI4MWO8QIRP0RAnizAJ9JhDDoD5Y7J6hz20osaED9E1+A8ACdEhj0
zZanARs73KJmO1yh85oHs0Y=
=oQGR
-----END PGP SIGNATURE-----

--Apple-Mail-21-982772760--
