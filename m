Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130435AbRBUMnn>; Wed, 21 Feb 2001 07:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRBUMne>; Wed, 21 Feb 2001 07:43:34 -0500
Received: from pat.uio.no ([129.240.130.16]:9601 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S130435AbRBUMnV>;
	Wed, 21 Feb 2001 07:43:21 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Roman Zippel <zippel@fh-brandenburg.de>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.10.10102200330330.25095-100000@zeus.fh-brandenburg.de>
	<14995.12200.46230.717479@notabene.cse.unsw.edu.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 21 Feb 2001 13:43:08 +0100
In-Reply-To: Neil Brown's message of "Wed, 21 Feb 2001 14:02:00 +1100 (EST)"
Message-ID: <shs4rxojjfn.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Neil Brown <neilb@cse.unsw.edu.au> writes:

     > - cannot do ".." lookups efficiently, or doesn't want to and
     > - can protect against this sort of loop (and any other issues
     >    that
     >     the VFS usually protects against) itself

     > then it can (with my patch) simply define decode_fh and
     > encode_fh and do whatever it likes, such as create a dentry
     > that isn't properly connected.

Do we really want to design for this though?

Being able to look up the parent directory is explicitly encoded in
all revisions of the NFS protocol. In NFSv2/v3 the names '.' and '..' 
have a clearly defined meaning, whereas in NFSv4 you are required to
support LOOKUPP.

I can't speculate about the needs of other networked filesystems which
may want to use this handle interface, but as far NFS is concerned we
are not interested in considering such special cases.

Cheers,
  Trond
