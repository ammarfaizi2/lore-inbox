Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSCSS3F>; Tue, 19 Mar 2002 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCSS2q>; Tue, 19 Mar 2002 13:28:46 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:48796 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S289272AbSCSS2b>;
	Tue, 19 Mar 2002 13:28:31 -0500
Date: Tue, 19 Mar 2002 13:28:10 -0500
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Theodore Tso <tytso@mit.edu>, Anton Blanchard <anton@samba.org>,
        Gerrit Huizenga <gh@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
Message-ID: <20020319132810.A727@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Anton Blanchard <anton@samba.org>, Gerrit Huizenga <gh@us.ibm.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020316061535.GA16653@krispykreme> <E16m7u7-0007yv-00@w-gerrit2> <20020317123434.GE22387@krispykreme> <20020317170955.A491@thunk.org> <3C959172.5080309@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 02:04:18AM -0500, Jeff Garzik wrote:
> Theodore Tso wrote:
> 
> >On Sun, Mar 17, 2002 at 11:34:34PM +1100, Anton Blanchard wrote:
> >
> >>>And this *without* the dcache_lock?  Hmm.  So you are saying there
> >>>may still be room for improvement?
> >>>
> >>I tried the dcache lock patches but found it hard to see a difference,
> >>for us the mm stuff still seems to be the bottleneck.
> >>
> >
> >Try the patch which gets rid of the BKL in ext2_get_block() --- if you
> >don't have that, let me know, I've got one kicking around that mostly
> >works except I haven't validated that it does the right thing if
> >quotas are enabled.
> >
> 
> Is yours different from what's in 2.5.x?

Yes it is, but it looks like Al's is better in any case.  (I hadn't
realized that Al's changes had gone into 2.5.recent; I've been
distracted recently with a few other things.)
	
						- Ted


