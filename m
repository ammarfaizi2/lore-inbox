Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269712AbRHCXoE>; Fri, 3 Aug 2001 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269711AbRHCXny>; Fri, 3 Aug 2001 19:43:54 -0400
Received: from weta.f00f.org ([203.167.249.89]:10128 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269708AbRHCXnr>;
	Fri, 3 Aug 2001 19:43:47 -0400
Date: Sat, 4 Aug 2001 11:44:30 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804114430.A18042@weta.f00f.org>
In-Reply-To: <20010804113525.E17925@weta.f00f.org> <E15SoaV-0004Et-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15SoaV-0004Et-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 12:42:38AM +0100, Alan Cox wrote:

    It can't come off the dentry as multiple people can have the same
    file open with different rights.

Yes, of course.

If that's the case, I'm not sure how you pick reasonable creds. for
fsyncing path components for a network filesystem, unless you (as the
calling user) open each component and sync that bit by bit --- which
could almost be done in libc (kernel is easier though).


  --cw

