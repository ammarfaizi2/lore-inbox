Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277524AbRJVSX3>; Mon, 22 Oct 2001 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277494AbRJVSXT>; Mon, 22 Oct 2001 14:23:19 -0400
Received: from [212.113.174.249] ([212.113.174.249]:16929 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S277434AbRJVSXH>;
	Mon, 22 Oct 2001 14:23:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Pedro Corte-Real <typo@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: UDP binding
Date: Mon, 22 Oct 2001 19:23:49 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01IuXZ2y200057c20@smtp.netcabo.pt>
X-OriginalArrivalTime: 22 Oct 2001 18:19:58.0814 (UTC) FILETIME=[286C0FE0:01C15B26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am running samba on a machine with 2 outside interfaces. I want samba to
listen only to one of them so I put these lines on smb.conf:

bind interfaces only = True
interfaces = 192.168.1.1 127.0.0.1

These setings produce this in netstat -a:

(...)
udp        0      0 192.168.1.1:138         0.0.0.0:*
udp        0      0 192.168.1.1:137         0.0.0.0:*
udp        0      0 0.0.0.0:138             0.0.0.0:*
udp        0      0 0.0.0.0:137             0.0.0.0:*
(...)

I was told this was because nmbd uses broadcast packets to do it's work and
for it to listen to broadcast packages it must listen to 0.0.0.0. Is this
true. Can't it bind to 192.168.1.0 instead?

How does linux's interface binding API work? Is this really necessary?

Greetings from Portugal,

Pedro.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71GQ82SBo0jBmgGARAoODAJ9FxNU2C+Eu3mtx5b4TTZ8KB9K5KACg2IY4
MkH7qmx8c9qq1xwB26GmDR4=
=A+CG
-----END PGP SIGNATURE-----
