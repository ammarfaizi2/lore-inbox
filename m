Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUITLrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUITLrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUITLrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:47:49 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:56195 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S266311AbUITLrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:47:42 -0400
Date: Mon, 20 Sep 2004 15:47:41 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
Message-ID: <20040920114741.GA3989@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru> <20040919200527.GA7184@tentacle.sectorb.msk.ru> <1095625531.7860.59.camel@lade.trondhjem.org> <20040919203619.GA8618@tentacle.sectorb.msk.ru> <1095634303.7860.122.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1095634303.7860.122.camel@lade.trondhjem.org>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 03:51:43PM -0700, Trond Myklebust wrote:
> Hmm...  It appears that it is indeed possible for both leases and flocks
> to be on the global "blocked_list", so the appended check is *not*
> redundant.
> Since flocks in particular do not initialize fl_owner, I suspect that
> you might be seeing wierd loops that were previously being avoided due
> to the ->fl_pid checks...
> 
> Cheers,
>  Trond
> 

> [PATCH] fix posix_locks_deadlock().

2.6.9-rc2-mm1 with this patch seems to be doing fine, thanks

> 
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

