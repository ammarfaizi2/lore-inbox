Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316175AbSEKAHj>; Fri, 10 May 2002 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316176AbSEKAHi>; Fri, 10 May 2002 20:07:38 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:40426 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316175AbSEKAHh>;
	Fri, 10 May 2002 20:07:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15580.24766.424170.333718@napali.hpl.hp.com>
Date: Fri, 10 May 2002 17:07:26 -0700
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020510234623.GC12975@turbolinux.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 10 May 2002 17:46:23 -0600, Andreas Dilger <adilger@clusterfs.com> said:

  Andreas> For 64-bit systems like Alpha, it is relatively easy to use
  Andreas> 8kB blocks for ext3.  It has been discouraged because such
  Andreas> a filesystem is non-portable to other (smaller page-sized)
  Andreas> filesystems.  Maybe this rationale should be re-examined -
  Andreas> I could probably whip up a configure option for e2fsprogs
  Andreas> to allow 8kB blocks in a few hours.

If you do this, please consider allowing a block size up to 64KB.
The ia64 kernel offers a choice of 4, 8, 16, and 64KB page size.

  Andreas> Does x86-64 and/or ia64 actually _use_ > 4kB page sizes?

ia64 linux normally uses > 4KB.  The recommended page size at the
moment is 16KB.  I didn't think 64KB would become realistic for quite
some time, but performance is surprisingly good, even on today's
systems.

	--david
