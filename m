Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWIEHB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWIEHB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWIEHB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:01:27 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:6530 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965183AbWIEHB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:01:26 -0400
Date: Tue, 5 Sep 2006 09:01:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Boldi <a1426z@gawab.com>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060905070110.GA30923@wohnheim.fh-wedel.de>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060903110507.GD4884@ucw.cz> <20060904125744.GA1961@wohnheim.fh-wedel.de> <200609050746.44502.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609050746.44502.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 September 2006 07:46:44 +0300, Al Boldi wrote:
> Jörn Engel wrote:
> >
> > Direct modification of branches is similar to direct modification of
> > block devices underneith a mounted filesystem.  While I agree that
> > such a thing _should_ not oops the kernel, I'd bet that you can easily
> > run a stresstest on a filesystem while randomly flipping bits in the
> > block device and get just that.
> 
> Not really a fair comparison.  The block level is conceptionally totally 
> different than the fs level, while a stackable fs is within the realms of 
> the fs level.

Well, I didn't realize that unionfs required its backing filesystems
to be mounted.  That's more like having the block device open in a
text editor while mounting ext3.  In the presence of such a design, an
oops clearly is not acceptable.  And this sort of design is just what
I was talking about when I said:

> > There are bigger problems in unionfs to worry about.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
