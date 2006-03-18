Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWCRKMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWCRKMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 05:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWCRKL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 05:11:57 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:24201 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932374AbWCRKL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 05:11:56 -0500
Date: Sat, 18 Mar 2006 03:11:02 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: Badari Pulavarty <pbadari@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support 2^32-1blocks(e2fsprogs)
Message-ID: <20060318101102.GZ30801@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	Badari Pulavarty <pbadari@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel <Ext2-devel@lists.sourceforge.net>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp> <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com> <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 18, 2006  14:57 +0900, Takashi Sato wrote:
> >elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs /dev/md0
> >mke2fs 1.38 (30-Jun-2005)
> >mke2fs: Filesystem too large.  No more than 2**31-1 blocks
> >        (8TB using a blocksize of 4k) are currently supported.
> >
> >When I try to create "ext3":
> 
> As I said in my previous mail, You should specify -F option to
> create ext2/3 which has more than 2**31-1 blocks.
> It is because of the compatibility.

Oh, using -F for this is highly dangerous.  That would allow mke2fs to
run on e.g. a mounted filesystem or something.  Instead use an option
like "-E 16tb" or something.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

