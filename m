Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTLBUN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTLBUNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:13:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44956 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264353AbTLBULV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:11:21 -0500
Date: Tue, 2 Dec 2003 20:11:14 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>, Larry McVoy <lm@work.bitmover.com>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202201114.GA10421@parcelfarce.linux.theplanet.co.uk>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202180251.GB17045@work.bitmover.com> <20031202181146.A27567@infradead.org> <20031202182037.GD17045@work.bitmover.com> <20031202182346.A27914@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202182346.A27914@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 06:23:46PM +0000, Christoph Hellwig wrote:
> On Tue, Dec 02, 2003 at 10:20:37AM -0800, Larry McVoy wrote:
> > So what's wrong with asking $VFS_MAINTAINER to refresh Marcelo's memory
> > about that?
> 
> There is no such thing as a VFS maintainer.  At least Al doesn't want
> to be in that position and I guess no one else would qualify (maybe
> akpm)

Generally I don't mind doing that kind of work.  *However*, in case of
XFS I'm very deliberately Not Touching That(tm).  Reason: I'm deeply
prejudiced against that codebase and (long-standing) situation with
its evolution.  IOW, I'm not the right guy to ask for comments.

<rant type=tired>
XFS codebase is bloated by attempt to imitate VFS interface of inferior
operating system (IRIX) and by demand to keep the common codebase between
Linux and IRIX versions, IRIX one being the master.  And that's not going
to change.  Moreover, locking in it is such that... well, I would not
recommend Larry to look at it - it's a fscking mess that is, AFAICS, long
past the point where maintainers had lost any control over it.  Basically,
all it demonstrates is that with sufficient thrust pigs fly^W^Wanything
can be debugged to the point where common codepaths almost never break.  
</rant>

I'm not touching that animal.  I would trust hch or akpm opinion on it,
but that's it - I know that they have enough clue to do it right.  Aside
of that, count me out whenever XFS is concerned.
