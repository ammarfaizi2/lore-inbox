Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269708AbRHCXpy>; Fri, 3 Aug 2001 19:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269711AbRHCXpr>; Fri, 3 Aug 2001 19:45:47 -0400
Received: from weta.f00f.org ([203.167.249.89]:11408 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269708AbRHCXph>;
	Fri, 3 Aug 2001 19:45:37 -0400
Date: Sat, 4 Aug 2001 11:46:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804114626.B18042@weta.f00f.org>
In-Reply-To: <20010804113525.E17925@weta.f00f.org> <Pine.GSO.4.21.0108031937120.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031937120.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 07:41:40PM -0400, Alexander Viro wrote:

    file->f_cred. Different people opening the same file can have
    different credentials (e.g. credentials can be revoked)

Sure, but if I

        f = open("/home/viro/file", ... );
        fsync(f);

I only have creds for 'file' --- I have no such thing for 'viro' or
'home', so I can't do anything sensible here.



  --cw




