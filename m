Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265674AbSJSUsx>; Sat, 19 Oct 2002 16:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSJSUsx>; Sat, 19 Oct 2002 16:48:53 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:44722 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265674AbSJSUsx>; Sat, 19 Oct 2002 16:48:53 -0400
Message-ID: <3DB1C9B2.3030500@kegel.com>
Date: Sat, 19 Oct 2002 14:08:02 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Charles 'Buck' Krasic" <krasic@acm.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>	<3DB0AD79.30401@netscape.com> <20021019065916.GB17553@mark.mielke.cc>	<3DB19AE6.6020703@kegel.com> <xu4u1jitg5v.fsf@brittany.cse.ogi.edu> <xu4ptu6tc5t.fsf@brittany.cse.ogi.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles 'Buck' Krasic wrote:
 >>In summary, a short count is every bit as reliable as EAGAIN to know
 >>that it is safe to wait on epoll_getevents.
 >
> Whoops.  I just realized a flaw in my own argument.  
> 
> With read, a short count might precede EOF.  Indeed, in that case,
> calling epoll_getevents would cause the connection to get stuck.

Maybe epoll should be extended with a specific EOF event.
Then short reads would be fine.
- Dan

