Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265322AbSJSUND>; Sat, 19 Oct 2002 16:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265399AbSJSUND>; Sat, 19 Oct 2002 16:13:03 -0400
Received: from cse.ogi.edu ([129.95.20.2]:64953 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265322AbSJSUNC>;
	Sat, 19 Oct 2002 16:13:02 -0400
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>
	<3DB0AD79.30401@netscape.com> <20021019065916.GB17553@mark.mielke.cc>
	<3DB19AE6.6020703@kegel.com> <xu4u1jitg5v.fsf@brittany.cse.ogi.edu>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 19 Oct 2002 13:18:54 -0700
In-Reply-To: <xu4u1jitg5v.fsf@brittany.cse.ogi.edu>
Message-ID: <xu4ptu6tc5t.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whoops.  I just realized a flaw in my own argument.  

With read, a short count might precede EOF.  Indeed, in that case,
calling epoll_getevents would cause the connection to get stuck.

Never mind my earlier message then. 

-- Buck

"Charles 'Buck' Krasic" <krasic@acm.org> writes:

> In summary, a short count is every bit as reliable as EAGAIN to know
> that it is safe to wait on epoll_getevents.

> -- Buck
