Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUCBM6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUCBM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:58:44 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:63424 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S261631AbUCBM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:58:43 -0500
Date: Tue, 2 Mar 2004 14:59:41 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Ben <linux-kernel-junk-email@slimyhorror.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: epoll and fork()
In-Reply-To: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
Message-ID: <Pine.LNX.4.58L0.0403021454070.20334@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 2 Mar 2004, Ben wrote:

> Is there a defined behaviour for what happens when a process with an epoll
> fd forks?
> 
> I've an app that inherits an epoll fd from its parent, and then
> unregisters some file descriptors from the epoll set. This seems to have
> the nasty side effect of unregistering the same file descriptors from the
> parent process as well. Surely this can't be right?
> 
> This is on 2.6.2.

Currect me if Im wrong but...

After a fork() arent all the parent's fds shared with the children ? This 
means that both processes can access the same fds right ? So the epoll fd 
(beeing just another fd as any other) is too shared between parent and 
child ? Which would mean both parent and child will "control" the same 
epoll kernel struct when doing epoll_ctl on it ?

> Ben

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARIVAPZzOzrZY/1QRAs+vAKCrkH/jSsJRCU6leScXz4EXC4kruQCeJfFo
/remKED2xAru7uInLoyhl4o=
=2cDV
-----END PGP SIGNATURE-----
