Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129411AbQKTTOG>; Mon, 20 Nov 2000 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTTN5>; Mon, 20 Nov 2000 14:13:57 -0500
Received: from smaug.wrq.com ([150.215.17.2]:35601 "EHLO smaug.wrq.com")
	by vger.kernel.org with ESMTP id <S129166AbQKTTNl>;
	Mon, 20 Nov 2000 14:13:41 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Ivan Kanis <ivank@wrq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.28856.472146.691962@jedi.wrq.com>
Date: Mon, 20 Nov 2000 10:43:04 -0800 (PST)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        nfs-devel@linux.kernel.org, Paul Pietromonaco <paulp@wrq.com>
Subject: Re: [BUG] knfsd causes file system corruption when files are locked.
In-Reply-To: <shsofzg9e6y.fsf@charged.uio.no>
In-Reply-To: <14867.6967.292440.394045@jedi.wrq.com>
	<14867.9090.689736.462761@notabene.cse.unsw.edu.au>
	<14867.18905.212001.355827@jedi.wrq.com>
	<shsofzg9e6y.fsf@charged.uio.no>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Trond" == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>>>>> " " == Ivan Kanis <ivank@wrq.com> writes:

    Ivan> space. I am running this on ext2fs. Fsck-ing the filesystem
    Ivan> does not help. The only way to recover the space is to
    Ivan> reformat the partition.
    Ivan>
    Ivan> [3.] knfsd, lock, NLM_SHARE, NLM_UNSHARE
    Ivan>
    Ivan> [4.] Linux version 2.2.16 (root@jedi) (gcc version 2.7.2.3)


    Trond> Please dig around in dejanews for the locking patch I
    Trond> posted on l-k last week (to be applied on top of
    Trond> 2.2.18pre21). It fixes 3 leaks in the locking code (amongst
    Trond> them the share leak).

Hi Trond,

Fantastic news: your patches fixed the bug! I hope it will make it in
the kernel pretty soon, I will be testing it some more today.

Thank you,

Ivan Kanis


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
