Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJPUh0>; Wed, 16 Oct 2002 16:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJPUh0>; Wed, 16 Oct 2002 16:37:26 -0400
Received: from cse.ogi.edu ([129.95.20.2]:22523 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S261395AbSJPUhY>;
	Wed, 16 Oct 2002 16:37:24 -0400
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210151601560.1554-100000@blue1.dev.mcafeelabs.com>
	<3DACA5E4.7090509@netscape.com> <xu4lm4zf6ew.fsf@brittany.cse.ogi.edu>
	<3DADB020.4060506@netscape.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 16 Oct 2002 13:39:28 -0700
In-Reply-To: <3DADB020.4060506@netscape.com>
Message-ID: <xu4vg42nmnz.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers <jgmyers@netscape.com> writes:

> Charles 'Buck' Krasic wrote:
> 
> In other words, you don't deny the problem.  Instead, you work around
> it in user space.

Not exactly.  I'm saying that the context in which /dev/epoll is used
(at least originally), is non-blocking socket IO.  Anybody who has
worked with that API can tell you there are subtleties, and that if
they're ignored, will certainly lead to pitfalls.  These are not the
fault of the /dev/epoll interface.

> Better to fix the API.  

> The kernel has more information than user space and can do a better
> job.  

I think we're talking across purposes. 

I know this is the AIO list, but I think epoll has value independent
of AIO.  They're complementary, not mutually exclusive.  

> In the kernel, the problem can be fixed once and for all, not
> over and over again in each different wrapper library. It's not even
> as if the change would break programs correctly written to the old
> API, not that we particularly care about programs written to the old
> API.

I agree if you are talking about AIO as a whole.  But epoll is more
limited in its scope, it really relates only to poll()/select not the
whole IO api.

-- Buck



