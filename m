Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRI3TTG>; Sun, 30 Sep 2001 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273992AbRI3TS5>; Sun, 30 Sep 2001 15:18:57 -0400
Received: from pat.uio.no ([129.240.130.16]:57839 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S273996AbRI3TSk>;
	Sun, 30 Sep 2001 15:18:40 -0400
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client woes [kernel 2.4.10]
In-Reply-To: <20010928220342.A18562@florence.intimate.mysticnet.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 Sep 2001 21:19:05 +0200
In-Reply-To: Chris Wilson's message of "Fri, 28 Sep 2001 22:03:42 +0100"
Message-ID: <shslmiwwkpi.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Wilson <chris@chris-wilson.co.uk> writes:

     > [Please CC me if you have any suggestions.]  I'm a bit hazy on
     > the details, but the synopsis is:

     > NFSv3 filesystems, same problem when mounted from either an
     > IRIX 6.5.12m or Linux/i386 2.4.10 server.

     > 2.4.7: all files are visible all of the time.  2.4.10: some
     > files are invisible to some processes.

     > The processes that I have noticed to be affected are the likes
     > of netscape, all gtk applications and find; perl globbing and
     > its readdir function similarly miss files. OTOH, grep and ls
     > function fine.

     > I'm not certain [read: no idea] what the connection is between
     > the files that do disappear. It does not appear to be simply
     > inode related, but those modified by the Linux client do seem
     > more vulnerable.

     > Unfortunately, I only had time to switch back in an old kernel
     > and confirm the issue before leaving work. The diff inside
     > fs/nfs appeared small, but so do icebergs. ;)

Known glibc bug. If you had trawled the archives a bit you would have
found it.

Set 32bitclients on the server and apply

   http://www.fys.uio.no/~trondmy/src/2.4.10/linux-2.4.10-seekdir.dif

Cheers,
  Trond
