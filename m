Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUCBOBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUCBOBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:01:24 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:6338 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S261611AbUCBOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:01:23 -0500
Date: Tue, 2 Mar 2004 16:02:22 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Ben <linux-kernel-junk-email@slimyhorror.com>,
       linux-kernel@vger.kernel.org
Subject: Re: epoll and fork()
In-Reply-To: <Pine.LNX.4.53.0403020809140.15850@chaos>
Message-ID: <Pine.LNX.4.58L0.0403021559120.23336@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
 <Pine.LNX.4.58L0.0403021454070.20334@ahriman.bucharest.roedu.net>
 <Pine.LNX.4.53.0403020809140.15850@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 2 Mar 2004, Richard B. Johnson wrote:

> The child's fds are separate, though. The parent can close
> its fds without affecting the child's and the child can close
> its fds without affecting the parent. 

They are not separate. It just that when using close you decrement the 
"reference" count to the "real" fd struct (like done on FS inodes). When 
reaches 0 its closed. So still as I said, fds are shared ;)

I havent check kernel sources, I just say that the fact the you can and 
need to close() a shared fd on each sharing process doesnt mean the 
sockets are independent.

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARJPwPZzOzrZY/1QRAulNAKDAHLz2mVPIfADedlIWA2U3QQFuFQCdFQyo
V5hpmpt+1r4DQDP1PTQig/k=
=HtbW
-----END PGP SIGNATURE-----
