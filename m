Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVDJAPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVDJAPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVDJAPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 20:15:07 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:1761 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261419AbVDJAPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 20:15:01 -0400
Date: Sat, 9 Apr 2005 17:14:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, andrea@suse.de,
       mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-ID: <20050410001435.GA23401@taniwha.stupidest.org>
References: <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random> <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org> <20050409155511.7432d5c7.davem@davemloft.net> <Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 04:13:51PM -0700, Linus Torvalds wrote:

> > I understand the arguments for compression, but I hate it for one
> > simple reason: recovery is more difficult when you corrupt some
> > file in your repository.

I've had this too.  Magic binary blobs are horrible here for data loss
which is why I'm not keen on subversion.

> Trust me, the way git does things, you'll have so much redundancy
> that you'll have to really _work_ at losing data.

It's not clear to me that compression should be *required* though.
Shouldn't we be able to turn this off in some cases?

> The bad news is that this is obviously why it does eat a lot of
> disk.

Disk is cheap, but sadly page-cache is not :-(

> Since it saves full-file commits, you're going to have a lot of
> (compressed) full files around.

How many is alot?  Are we talking 100k, 1m, 10m?
