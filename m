Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbRESE1x>; Sat, 19 May 2001 00:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbRESE1n>; Sat, 19 May 2001 00:27:43 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:13575 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261642AbRESE1b>; Sat, 19 May 2001 00:27:31 -0400
Date: Sat, 19 May 2001 17:26:23 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010519172623.B4434@metastasis.f00f.org>
In-Reply-To: <20010515195607.A13722@metastasis.f00f.org> <Pine.LNX.4.31.0105150058370.22938-100000@p4.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0105150058370.22938-100000@p4.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 01:06:47AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 01:06:47AM -0700, Linus Torvalds wrote:

    But no, I doubt we'll move _all_ metadata into the page-cache. I
    doubt, for example, that we'll find people re-doing all the other
    filesystems. So even if ext2 was page-cache only, what about all
    the 35 other filesystems out there in the standard sources, never
    mind others that haven't been integrated (XFS, ext3 etc..).

Hmm... what about dropping block device per se' and creating a
pseudo-fs (say /dev/blk/) that gives a page-cache view of the
underlying raw devices?

That way older filesystems and tools could use that view of things
until they are moved into the page-cache, and those people without
the dependence of those filesystems can complete forgo all of this?




  --cw
