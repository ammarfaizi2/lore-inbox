Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTAVNco>; Wed, 22 Jan 2003 08:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAVNco>; Wed, 22 Jan 2003 08:32:44 -0500
Received: from pat.uio.no ([129.240.130.16]:21751 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267489AbTAVNcn>;
	Wed, 22 Jan 2003 08:32:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15918.40855.583602.576856@charged.uio.no>
Date: Wed, 22 Jan 2003 14:41:43 +0100
To: Oliver Tennert <tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org, kaw@science-computing.de
Subject: Re: NFS client problem and IO blocksize
In-Reply-To: <Pine.GHP.4.02.10301221424430.848-100000@alderaan.science-computing.de>
References: <15918.38755.480267.413305@charged.uio.no>
	<Pine.GHP.4.02.10301221424430.848-100000@alderaan.science-computing.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oliver Tennert <tennert@science-computing.de> writes:

     > As you can see, the actual server-side s_blksize is 4k, whereas
     > the Linux client takes it to be 512 bytes. An strace output
     > confirms that a "cat" of a file actually uses 512 byte IO
     > chunks.

I'm taking the value from the NFSv3 'wtmult' attribute, which is
described thus in RFC1813:

      wtmult
         The suggested multiple for the size of a WRITE
         request.

If the AIX NFS server is returning 512 bytes, then that's what
'statfs' returns.

Cheers,
  Trond
