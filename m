Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTATVzY>; Mon, 20 Jan 2003 16:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTATVzX>; Mon, 20 Jan 2003 16:55:23 -0500
Received: from assisi.INS.CWRU.Edu ([129.22.8.14]:16350 "EHLO
	assisi.INS.cwru.edu") by vger.kernel.org with ESMTP
	id <S267101AbTATVzV>; Mon, 20 Jan 2003 16:55:21 -0500
Date: Mon, 20 Jan 2003 17:04:19 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS problems
Message-ID: <20030120220419.GA198@lothlorien.cwru.edu>
References: <20030120204303.GA459@lothlorien.cwru.edu> <20030120135358.7d804598.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120135358.7d804598.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 01:53:58PM -0800, Andrew Morton wrote:
> I seem to recall that there was some silly bug wherein rlimits are applied to
> blockdevs.  The workaround was to run mkfs from a new root login shell,
> rather than from `su root'.  Because in the latter case, root inherited
> filesize limits.
> 

Yeah, I tried that and it didn't work.  Then I did a google search for the
error, and found that I have to set root's limits to unlimited, because for
some reason or another, they got messed up.  Now everything is working, I just
have to run 'unlimit filesize' whenever I want to format a partition or
anything.  Not sure what messed it up, but this is fine for now ;p

-Justin

-- 
Registered Linux user 260206


