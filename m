Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278481AbRJ3WFo>; Tue, 30 Oct 2001 17:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278476AbRJ3WFe>; Tue, 30 Oct 2001 17:05:34 -0500
Received: from mons.uio.no ([129.240.130.14]:34743 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S278472AbRJ3WF0>;
	Tue, 30 Oct 2001 17:05:26 -0500
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_lookup_validate and dud inodes
In-Reply-To: <m3zo68rjk7.fsf@quimbies.gnus.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 Oct 2001 23:05:57 +0100
In-Reply-To: <m3zo68rjk7.fsf@quimbies.gnus.org>
Message-ID: <shs8zds941m.fsf@susy.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Lars Magne Ingebrigtsen <larsi@gnus.org> writes:

     > [larsi@quimbies ~]$ ls -l /tftpboot/sparky/lib/libe2p.so.2*
     > lrwxrwxrwx 1 root root 13 Oct 30 20:23
     > /tftpboot/sparky/lib/libe2p.so.2 -> libe2p.so.2.3 -rw-r--r-- 1
     > root root 13400 Sep 22 17:15 /tftpboot/sparky/lib/libe2p.so.2.3

     > So the error message is when trying to access the symlink.

<snip>

     > Is this a known bug?

Known and fixed in the 2.2.20-pre series. It's just that the symlink
code in 2.2.19 doesn't call nfs_revalidate_inode() in order to verify
data cache consistency.

Cheers,
   Trond
