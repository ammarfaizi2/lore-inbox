Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSBCOLL>; Sun, 3 Feb 2002 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSBCOLC>; Sun, 3 Feb 2002 09:11:02 -0500
Received: from tapu.f00f.org ([63.108.153.39]:41918 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S287212AbSBCOKv>;
	Sun, 3 Feb 2002 09:10:51 -0500
Date: Sun, 3 Feb 2002 06:09:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Stephen Lord <lord@sgi.com>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020203140926.GA14532@tapu.f00f.org>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org> <3C5D3DE9.4080503@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5D3DE9.4080503@sgi.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 07:40:57AM -0600, Stephen Lord wrote:

    What we had were two flags, one which indicated use direct I/O,
    and another which indicated return an error to user space rather
    than go through buffers.  So lie to me and make it work, or don't
    lie to me options I suppose.

This seems way to complex in the case of reiserfs... you're only going
to see tails for small files (typically under 16k) and for the tail
part when less than a block.

Since O_DIRECT much be blocked sized and block aligned, I'm not sure
if this is a problem at present...

    I suspect the reason XFS never did small files in the inode was
    because of the problems with implementing mmap and O_DIRECT.

How does IRIX deal with O_DIRECT read/writes of a mapped area?
Invalidate them or just accept things as being incoherent?


    --cw
