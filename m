Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289942AbSAKNPt>; Fri, 11 Jan 2002 08:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289944AbSAKNPj>; Fri, 11 Jan 2002 08:15:39 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:41272 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289942AbSAKNPX>; Fri, 11 Jan 2002 08:15:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: trond.myklebust@fys.uio.no
Subject: [NFS] some strangeness (at least) with linux-2.4.17-NFS_ALL patch
Date: Fri, 11 Jan 2002 14:15:11 +0100
X-Mailer: KMail [version 1.3.2]
Organization: LISA GmbH
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111131528.44F8613E6@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond et al.,

after applying $subject and resolving the rej with 2.4.18-pre1, 
I found the following strangeness in my SuSE 7.3 based NFS diskless setup:

Trying to start openuniverse for the first time (ever), it complaint about
a missing config file. SuSE installed it's data at /usr/share/openuniverse 
with the config file conf/ou.conf symlinked to ../../../../etc/ou.conf (=> 
/etc/ou.conf), which was missing within my diskless setup.

The problem is, ls on the client side complains about an I/O error, when 
listing the conf/ dir.

After removing this symlink (within the server), ls is OK within
the client. Trying to copy servers /etc/ou.conf file to
/usr/share/openuniverse within the client, cp complains about to many levels 
of symlinks?!? (/usr is shared)

May be I missed/confused some patches. I could send you a plain
copy of the interresting modules, if you like. 

Somehow, the dir entry on the client survived the rm from the server.

Compiling/KDE 2.2.2 Desktop is working fine so far.

Any ideas?

Cheers,
Hans-Peter
