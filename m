Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284267AbRLBSz3>; Sun, 2 Dec 2001 13:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282561AbRLBSzV>; Sun, 2 Dec 2001 13:55:21 -0500
Received: from pop.gmx.net ([213.165.64.20]:5688 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282567AbRLBSzP>;
	Sun, 2 Dec 2001 13:55:15 -0500
Date: Sun, 2 Dec 2001 19:55:05 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Kenneth Johansson <ken@canit.se>
Cc: ce@ruault.com, stephane@tuxfinder.org, jmerkey@timpanogas.org,
        jjs@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
Message-Id: <20011202195505.57363019.rene.rebe@gmx.net>
In-Reply-To: <3C0A6ECF.82C34304@canit.se>
In-Reply-To: <3C0954D5.6AA3532B@ruault.com>
	<3C09580F.5F323195@pobox.com>
	<3C095B0B.7EA478C1@ruault.com>
	<003601c17ac2$7a8dec10$f5976dcf@nwfs>
	<3C096DB3.204CE41C@pobox.com>
	<001e01c17acb$a44b69c0$f5976dcf@nwfs>
	<20011202023145.A1628@emeraude.kwisatz.net>
	<3C09B3FA.61777E84@ruault.com>
	<3C0A6ECF.82C34304@canit.se>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 19:11:27 +0100
Kenneth Johansson <ken@canit.se> wrote:

> I had problems with symlinks also. This is what I know about it so far.
> 
> I only get/got this problem on a server running 2.4.10 using reiserfs and when the
> files was used over NFS.
> Once it got itself into this state it is possible to create symlinks by hand but when
> untaring an archive 90% of all links was wrong. Doing the same on the server directly
> showed no problem.
> 
> A reboot of the client did not help but rebooting the server did. I have since
> upgraded to 2.4.16 but only run for a few hours the last time needed many days to show
> this problem so it could still be there.
> 
> A nice program to use is symlinks that shows all links that points to a file not
> existing
> symlinks -r . | egrep "^dangling"

This general NFS v3 sym-link bug was fixed in 2.4.11 or .12 it was "only" caused
by a non-zero terminated string ...

btw. my 2.4.16 file-server using ReiserFS on a soft-raid5 device of 3 IBM
IDE disks has not yet shown a corruption (but could be a bit faster ...).

server1:~ # cat /proc/version 
Linux version 2.4.16 (root@server1.localnet) (gcc version 2.95.3 20010315 (release)) #2 Tue Nov 27 18:58:48 CET 2001
server1:~ # uptime
  7:54pm  up 3 days,  4:02,  1 user,  load average: 0.01, 0.03, 0.00

[...]

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
