Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKPDOC>; Wed, 15 Nov 2000 22:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPDNx>; Wed, 15 Nov 2000 22:13:53 -0500
Received: from smaug.wrq.com ([150.215.17.2]:22276 "EHLO smaug.wrq.com")
	by vger.kernel.org with ESMTP id <S129060AbQKPDNq>;
	Wed, 15 Nov 2000 22:13:46 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Ivan Kanis <ivank@wrq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14867.18905.212001.355827@jedi.wrq.com>
Date: Wed, 15 Nov 2000 18:43:37 -0800 (PST)
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: [BUG] knfsd causes file system corruption when files are locked. 
In-Reply-To: <14867.9090.689736.462761@notabene.cse.unsw.edu.au>
In-Reply-To: <14867.6967.292440.394045@jedi.wrq.com>
	<14867.9090.689736.462761@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wednesday November 15, ivank@wrq.com wrote:
    Ivan> [1.] knfsd causes file system corruption when files are locked.
    Ivan>
    Ivan> [2.] Lock down a file using the NLM_SHARE sharing
    Ivan> mechanism. Remove the file. Unlock the file using
    Ivan> NLM_UNSHARE. The filesystem does not recover the file space. I
    Ivan> am running this on ext2fs. Fsck-ing the filesystem does not
    Ivan> help. The only way to recover the space is to reformat the
    Ivan> partition.
    Ivan>
    Ivan> [3.] knfsd, lock, NLM_SHARE, NLM_UNSHARE
    Ivan>
    Ivan> [4.] Linux version 2.2.16 (root@jedi) (gcc version 2.7.2.3)


>>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:

    Neil> Lots of changes have gone into knfsd since 2.2.16.  Could
    Neil> you please try again with either a later 2.2.18pre kernel,
    Neil> or 2.2.16 with patches from
    Neil>    http://nfs.sourceforge.net/
    Neil> applied?  Thanks.

    Neil> Quick guide is:
    Neil>     2.2.16
    Neil>   plus
    Neil>     http://www.fys.uio.no/~trondmy/src/nfsv3-old/linux-2.2.16-nfsv3-0.22.0.dif.bz2
    Neil>   plus
    Neil>     http://download.sourceforge.net/nfs/kernel-nfs-dhiggen_merge-2.0.gz

    Neil> NeilBrown

I can reproduce the bug using:

Linux version 2.2.18pre21 (root@jedi) (gcc version 2.7.2.3)

I don't have to type vers=2 to mount a linux nfs share on Solaris
(yeah!)

Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
