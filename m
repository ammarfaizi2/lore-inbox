Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289974AbSAOPi7>; Tue, 15 Jan 2002 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289977AbSAOPij>; Tue, 15 Jan 2002 10:38:39 -0500
Received: from mons.uio.no ([129.240.130.14]:16859 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S289974AbSAOPia>;
	Tue, 15 Jan 2002 10:38:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
Date: Tue, 15 Jan 2002 16:38:05 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Nikita Danilov <Nikita@Namesys.COM>, Neil Brown <neilb@cse.unsw.edu.au>,
        Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de> <15428.12621.682479.589568@charged.uio.no> <15428.19063.859280.833041@laputa.namesys.com>
In-Reply-To: <15428.19063.859280.833041@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QVf3-0002NG-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15. January 2002 16:27, Nikita Danilov wrote:

> In reiserfs there is no static inode table, so we keep global generation
> counter in a super block which is incremented on each inode deletion,
> this generation is stored in the new inodes. Not that good as per-inode
> generation, but we cannot do better without changing disk format.

Am I right in assuming that you therefore cannot check that the filehandle is 
stale if the client presents you with the filehandle of the 'old' inode 
(prior to deletion)?
However if the client compares the 'old' and 'new' filehandle, it will find 
them to be different?

Cheers,
  Trond
