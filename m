Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSBZXDk>; Tue, 26 Feb 2002 18:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBZXDb>; Tue, 26 Feb 2002 18:03:31 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:44931 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S287386AbSBZXDQ>;
	Tue, 26 Feb 2002 18:03:16 -0500
Subject: Re: Congrats Marcelo,
From: Steve Lord <lord@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fqZK-0002NE-00@the-village.bc.nu>
In-Reply-To: <E16fqZK-0002NE-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 16:59:34 -0600
Message-Id: <1014764374.5993.183.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 16:59, Alan Cox wrote:
> > Someone has got to kill this assumption people have about XFS, it
> > makes much smaller changes than some things which have gone in,
> > the odd VM rewrite here and there to name some. Given that we now
> 
> Which was a complete disaster. IBM submitted Jfs into the -ac tree with
> no lines of code changed outside fs/jfs. That is really the benchmark.


Alan, I agree the VM changes had their issues, bad example, but LOTs of
things have gone into 2.4 which are more impactive than XFS, I just want
to get out of this image of XFS being the filesystem which ate the
kernel.

Yes jfs went in cleanly, because they reimplemented their filesystem
from the ground up, and had a large budget to do it. XFS does not fit
so cleanly because we brought along some features other filesystems did
not have:

  o Posix ACL support
  o The ability to do online filesystem dumps which are coherent with
    the system call interface
  o delayed allocation of file data
  o DMAPI

As it is we did all of these, and we seem to have half the Linux NAS
vendors in the world building xfs into their boxes.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
