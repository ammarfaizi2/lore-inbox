Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVAVCfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVAVCfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVAVCfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:35:09 -0500
Received: from internal.actusa.net ([205.147.44.175]:60372 "EHLO
	internal.actusa.net") by vger.kernel.org with ESMTP id S262646AbVAVCfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:35:03 -0500
Message-ID: <41F1BBD1.8020304@actusa.net>
Date: Fri, 21 Jan 2005 18:34:57 -0800
From: Stuart Sheldon <stu@actusa.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Advise on: panic - Attempting to free lock with active block list
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (internal.actusa.net [205.147.44.175]); Fri, 21 Jan 2005 18:34:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just a heads up,

I had the same panic and screen error with a 2.6.9 PIII SMP system
acting as an NFS client. This was after downgrading from a 2.6.10 kernel
that was panic'ing in the same way. I reverted to 2.6.8 but left the
Server (also a PIII SMP system) running 2.6.9. This occurred during
moderate to heavy NFS activity. The patch referenced in
http://seclists.org/lists/linux-kernel/2005/Jan/1237.html appeared to
resolve the panic with 2.6.10, but I was having strange things happen,
like failing to release file locks when the client reboots. This is a
production system and needs to be available for users. I am currently
trying to piece together another smp box to test with. I will post more
if I can duplicate the problem on demand.

We have a duplicate system that is not SMP that has not shown any of
these problems. That might be by chance though...

Hope this info is useful,

Stu Sheldon
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB8bvRN2GRn8Iq8wYRAmLVAJ0dp1Zk/5KpraG1saWUCNoMD17IogCgmyPr
kOHIUD5g5EqNl+JCYzWuUc0=
=1Wji
-----END PGP SIGNATURE-----
