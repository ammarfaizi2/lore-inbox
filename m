Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSJMRGF>; Sun, 13 Oct 2002 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJMRGE>; Sun, 13 Oct 2002 13:06:04 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:61571 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261554AbSJMRFw>;
	Sun, 13 Oct 2002 13:05:52 -0400
Date: Sun, 13 Oct 2002 12:11:28 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
cc: davem@ninka.net
Subject: smbfs compile errors for latest 2.5.42-bk
Message-ID: <Pine.LNX.4.44.0210131208550.26201-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sendmsg/recvmsg changes appear to have broke smbfs:

[tmolina@dad linux-2.5-tm]$ make modules > makemodules
fs/smbfs/sock.c: In function `_recvfrom':
fs/smbfs/sock.c:61: incompatible type for argument 1 of `kiocb_to_siocb'
fs/smbfs/sock.c: In function `smb_receive_drop':
fs/smbfs/sock.c:330: incompatible type for argument 1 of `kiocb_to_siocb'
fs/smbfs/sock.c:341: `scm' undeclared (first use in this function)
fs/smbfs/sock.c:341: (Each undeclared identifier is reported only once
fs/smbfs/sock.c:341: for each function it appears in.)
fs/smbfs/sock.c: In function `smb_receive':
fs/smbfs/sock.c:399: `iocb' undeclared (first use in this function)
fs/smbfs/sock.c:400: `si' undeclared (first use in this function)
fs/smbfs/sock.c: In function `smb_send_request':
fs/smbfs/sock.c:467: incompatible type for argument 1 of `kiocb_to_siocb'
fs/smbfs/sock.c:479: `scm' undeclared (first use in this function)
make[2]: *** [fs/smbfs/sock.o] Error 1
make[1]: *** [fs/smbfs] Error 2
make: *** [fs] Error 2




