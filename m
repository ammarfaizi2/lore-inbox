Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbRAGVya>; Sun, 7 Jan 2001 16:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132239AbRAGVyV>; Sun, 7 Jan 2001 16:54:21 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:52741
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131208AbRAGVyN>; Sun, 7 Jan 2001 16:54:13 -0500
Date: Mon, 8 Jan 2001 10:54:09 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
Message-ID: <20010108105409.B3904@metastasis.f00f.org>
In-Reply-To: <E14FLi2-0003Cy-00@the-village.bc.nu> <Pine.LNX.4.10.10101071153470.27944-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101071153470.27944-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 11:56:38AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 11:56:38AM -0800, Linus Torvalds wrote:

    This is actually where I agree with whoever it was that said that
    ramfs as it stands now (without the limit checking etc) is much
    nicer simply because it can act as an example of how to do a
    simple filesystem.

That was me. ramfs is mimnimalist and if we must extend/bloat ramfs
then I suggest we adding a backing store al la tmpfs or memfs and
change it's name.

Don't get me wrong, I _like_ ramfs and want a backing store and
perhaps limits (I use ramfs for /tmp and decided to put over a
million files in there once as a test, kaboom), but I'm no guru and
would love to see ramfs stay as is -- because _I_ can understand it.
To me, that is worth a lot -- ramfs is only 8k, tiny to keep about as
an example I should think.

    I wonder what to do about this - the limits are obviously useful,
    as would the "use swap-space as a backing store" thing be. At the
    same time I'd really hate to lose the lean-mean-clean ramfs.

ramfs-> skeletonfs    
ramfs+bloat -> vmfs




  --cw
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
