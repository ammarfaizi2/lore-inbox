Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVD0VdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVD0VdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVD0VdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:33:16 -0400
Received: from thunk.org ([69.25.196.29]:6327 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262031AbVD0VdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:33:11 -0400
Date: Wed, 27 Apr 2005 17:32:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
       mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-ID: <20050427213250.GA8211@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Florian Weimer <fw@deneb.enyo.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
References: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com> <20050427190144.GA28848@cip.informatik.uni-erlangen.de> <874qds5489.fsf@deneb.enyo.de> <426FFE58.4050901@zytor.com> <87r7gw3p6p.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r7gw3p6p.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:06:06PM +0200, Florian Weimer wrote:
> * H. Peter Anvin:
> 
> > Florian Weimer wrote:
> >> Benchmarks are actually a bit tricky because as far as I can tell,
> >> once you hash the directories, they are tainted even if you mount your
> >> file system with ext2.
> >
> > That's what fsck -D is for.
> 
> Ah, cool, I didn't know that it works the other way, too.  Thanks.

If htree support is disabled, e2fsck -D sorts by name, which was a
silly thing to do.  I should change it to sort by inode number instead
(trivial patch).  This might not be a problem for the maildir format,
given its naming convention.

						- Ted
