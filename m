Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136512AbREDVMu>; Fri, 4 May 2001 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136511AbREDVMb>; Fri, 4 May 2001 17:12:31 -0400
Received: from klawatti.watchguard.com ([64.74.30.161]:17672 "EHLO
	klawatti.watchguard.com") by vger.kernel.org with ESMTP
	id <S136510AbREDVMT>; Fri, 4 May 2001 17:12:19 -0400
From: bp@terran.org
Date: Fri, 4 May 2001 14:09:16 -0700 (PDT)
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Sending packets from within the kernel
Message-ID: <Pine.LNX.4.31.0105041356080.13540-100000@uranus.terran>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am working on an kernel module which forwards TCP segments from one
interface to another (basic routing, no proxy or listener socket), but
which needs to be able to generate some segments completely independently
of the client<-->server data stream.  For example, when receiving a SYN
segment from the client, I want the module to be able to respond itself
with a SYN+ACK on behalf of the server (and drop the SYN).

I understand how silly this sounds.  Setting aside the reasoning and
pitfalls of such a desire, technically what is the best way to do it?  I've
reviewed the SYN_COOKIE and RST_COOKIE logic and it seems we must create a
dummy socket which is not attached to any inode.

Is there a cheaper way of accomplishing the same thing, assuming I don't
need to record any state for the endpoints?

Sincerely,
- -bp
- --
# bp at terran dot org
# http://www.terran.org/~bryan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE68xp/qAGIoYtXZJERAtvDAJ0QCgrfzdoqnRr5hWNpuersTtKpSwCgrtNl
gnGcBjCt+W41tHunmyTuFAM=
=GCRW
-----END PGP SIGNATURE-----

