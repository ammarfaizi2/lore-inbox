Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbQKPPHA>; Thu, 16 Nov 2000 10:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQKPPGv>; Thu, 16 Nov 2000 10:06:51 -0500
Received: from mons.uio.no ([129.240.130.14]:46845 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129927AbQKPPGh>;
	Thu, 16 Nov 2000 10:06:37 -0500
To: Ivan Kanis <ivank@wrq.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        nfs-devel@linux.kernel.org
Subject: Re: [BUG] knfsd causes file system corruption when files are locked.
In-Reply-To: <14867.6967.292440.394045@jedi.wrq.com> <14867.9090.689736.462761@notabene.cse.unsw.edu.au> <14867.18905.212001.355827@jedi.wrq.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Nov 2000 15:36:21 +0100
In-Reply-To: Ivan Kanis's message of "Wed, 15 Nov 2000 18:43:37 -0800 (PST)"
Message-ID: <shsofzg9e6y.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Acadia"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ivan Kanis <ivank@wrq.com> writes:

    Ivan> space. I am running this on ext2fs. Fsck-ing the filesystem
    Ivan> does not help. The only way to recover the space is to
    Ivan> reformat the partition.
    Ivan>
    Ivan> [3.] knfsd, lock, NLM_SHARE, NLM_UNSHARE
    Ivan>
    Ivan> [4.] Linux version 2.2.16 (root@jedi) (gcc version 2.7.2.3)


Please dig around in dejanews for the locking patch I posted on l-k
last week (to be applied on top of 2.2.18pre21). It fixes 3 leaks in
the locking code (amongst them the share leak).

If you can't find it, I'll be happy to post it via private mail...

Cheers,
  Trond

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
