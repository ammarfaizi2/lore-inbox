Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUHGOVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUHGOVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUHGOVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:21:41 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:39062 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S262547AbUHGOVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:21:39 -0400
Date: Sat, 7 Aug 2004 16:21:34 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
Message-ID: <20040807142134.GA17265@unicorn.sch.bme.hu>
References: <4113B8A2.4050609@lougher.demon.co.uk> <4113D4CD.5080109@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4113D4CD.5080109@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 04:58:21AM +1000, Nick Piggin wrote:
> Phillip Lougher wrote:
> >Nick Piggin wrote:
> >
> >>On second thought, maybe not. I think your filesystem is at fault.
> >
> >
> >No I'm not wrong here. With a read-only filesystem i_size can
> >never change, there are no possible race conditions.  If a too
> >large index is passed it is a VFS bug.  Are you suggesting I should
> >start to code assuming the VFS is broken?
> >
> 
> No, I suggest you start to code assuming this interface does
> what it does. I didn't say there is no bug here, but nobody
> else's filesystem breaks.

Well, that might not exactly be true. We have noticed the same problem 
with ext2 too. Maybe I can send an example initrd image which triggers 
the bug on Monday.


-- 
Pozsar Balazs
