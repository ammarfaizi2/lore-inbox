Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWIGPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWIGPlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWIGPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:41:11 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:61841 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161003AbWIGPlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:41:06 -0400
Date: Thu, 7 Sep 2006 17:39:51 +0200
From: Mattia Dongili <malattia@linux.it>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: JFS - real deadlock and lockdep warning (2.6.18-rc5-mm1)
Message-ID: <20060907153951.GB13103@inferi.kami.home>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <20060905203309.GA3981@inferi.kami.home> <1157580028.8200.72.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157580028.8200.72.camel@kleikamp.austin.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 05:00:28PM -0500, Dave Kleikamp wrote:
[...]
> > I suspect JFS is guilty, anyway my HD has these partitions:
> 
> I haven't got around to instrumenting jfs properly with
> mutex_lock_nested(), so I know jfs doesn't run clean with lockdep
> enabled.  What that means is that these warnings don't necessarily point
> to a real problem, and on the other hand, lockdep hasn't been run
> correctly against jfs to prove that the mutex usage is safe.
> 
> That said, I'm not aware of any known problems in jfs resulting in a
> deadlock.  Unfortunately, without being able to use sysrq, I don't have
> any real good ideas for you off the top of my head to further track down
> the problem.

yup... don't know if it could put some light but simply doing

$ mv ~/.firefox ~/.firefox.old
$ cp ~/.firefox.old ~/.firefox

in order to allocate different inodes (right?) I can run Firefox
with my favourite skin (the one that was causing the hang before).

> I'm pretty busy this week, but I'll try to get the lockdep stuff right
> in jfs as soon as possible.  Who knows?  Maybe it will find a real
> locking problem.

I'll try to keep the filesystem as is to be able to test any fix/test
you'll propose (Eclipse still hangs the computer). Fortunately I have
one more spare partition where I can move /home.

Thanks
-- 
mattia
:wq!
