Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUE2ACr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUE2ACr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 20:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUE2ACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 20:02:47 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:60127 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S264184AbUE2ACq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 20:02:46 -0400
Date: Fri, 28 May 2004 15:08:09 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: "Theodore Ts'o" <tytso@mit.edu>, Mark Watts <m.watts@eris.qinetiq.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <20040528190809.GB20758@cox.net>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528062141.GA18118@cox.net> <20040528150119.GE18449@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528150119.GE18449@thunk.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:01:19AM -0400, Theodore Ts'o wrote:
> On Fri, May 28, 2004 at 02:21:41AM -0400, Chris Shoemaker wrote:
> > > Agreed - fmirror is so much more reliable than rsync (imho) that it makes 
> > > rsync into a worst-case option for retrieving files.
> > 
> >   bug reports to rsync@lists.samba.org are appreciated...
> > 
> 
> The main problem with rsync that I can see is that it is fairly heavy
> weight on the server, so many servers (including mirrors.kernel.org)
> have a maximum number of connections set to something pathetically
> small, like say 5 connections.  

Do you mean w.r.t. memory usage or storage i/o?  I know that creating
the file list can take up a lot of memory for large lists.  

Five connections seems pretty low.  I've never personally hit any
connection limit, and I make moderate use of rsync.  On the server side 
I know of several rsync servers offering >1 million files.  Not sure how 
hard they work, but they're highly available.

> 
> I remember Tridge trying to get someone to implement checksum caching
> for rsync servers some 4+ years ago, which would surely help.  Did
> that ever get done?  If so, convincing the server admins that it's OK
> to up the maximum number of rsync connections would be the next step.
> 
> 						- Ted

I'm sure there are some things that can be done to make rsync 
lighter-weight.  Checksums aren't cached, but the problem is, the 
checksum seed is varible, so that might not be the best optimization.

Overall, I'd have to disagree with the parent-post saying that rsync is
worst-case option.  It's not perfect, but I much prefer rsync over
fmirror.  I think it's more convenient and, although I have no rigorous
measurements, but it seems faster, to boot.

-chris
