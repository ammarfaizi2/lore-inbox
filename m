Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSAUPdZ>; Mon, 21 Jan 2002 10:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSAUPdP>; Mon, 21 Jan 2002 10:33:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61261 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285618AbSAUPc4>; Mon, 21 Jan 2002 10:32:56 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Shawn <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201201924020.32617-100000@imladris.surriel.com>
	<3C4B3703.6080101@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jan 2002 08:29:46 -0700
In-Reply-To: <3C4B3703.6080101@namesys.com>
Message-ID: <m1vgdvg1sl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> >
> >That is exactly what the VM does.
> >
> So basically you continue to believe that one cache manager shall rule them all,
> 
> and in the darkness as to their needs, bind them.

Hans any other case generally sucks, and at best works well until the
VM changes and then breaks.  The worst VM's I have seen are the home
spun cache management routines for compressing filesystems.   So
trying for a generic solution is very good.

I suspect it easier to work out the semantics needed for reiserfs and
xfs to do delayed writes in the page cache than to work out the
semantics needed for having to competing VM's...

Eric




