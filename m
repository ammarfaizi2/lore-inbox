Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJUQhy>; Mon, 21 Oct 2002 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJUQhy>; Mon, 21 Oct 2002 12:37:54 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63412 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261506AbSJUQhw>; Mon, 21 Oct 2002 12:37:52 -0400
Subject: Re: [PATCH] async poll for 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: "Charles 'Buck' Krasic" <krasic@acm.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3DADB020.4060506@netscape.com>
References: <Pine.LNX.4.44.0210151601560.1554-100000@blue1.dev.mcafeelabs.com>
	<3DACA5E4.7090509@netscape.com> <xu4lm4zf6ew.fsf@brittany.cse.ogi.edu> 
	<3DADB020.4060506@netscape.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 17:58:17 +0100
Message-Id: <1035219498.27318.205.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 19:29, John Gardiner Myers wrote:
> Better to fix the API.  The kernel has more information than user space 
> and can do a better job.  In the kernel, the problem can be fixed once 
> and for all, not over and over again in each different wrapper library. 
>  It's not even as if the change would break programs correctly written 
> to the old API, not that we particularly care about programs written to 
> the old API.

I think a chunk of the poll scaling problem is better addressed by
futexes. If I can say "this futex list for this fd for events X Y and Z"
I can construct almost all the efficient stuff I need out of the futex
interfaces, much like doing it with SIGIO setting flags but a lot less
clocks

Alan
