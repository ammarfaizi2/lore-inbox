Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSJPTlc>; Wed, 16 Oct 2002 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJPTlc>; Wed, 16 Oct 2002 15:41:32 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:18581 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261350AbSJPTlc>; Wed, 16 Oct 2002 15:41:32 -0400
Message-ID: <3DADC516.1050704@kegel.com>
Date: Wed, 16 Oct 2002 12:59:18 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: John Gardiner Myers <jgmyers@netscape.com>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210151521090.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9859.5060005@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> Nonetheless, the requirement for user space to test the condition after 
> the registration, not before, is subtle.  A program which does these in 
> the wrong order is still likely to pass QA and will fail in production 
> in a way that will be difficult to diagnose.  There is no rational 
> reason for the kernel to not test the condition upon registration.

As long as we agree that the kernel may provide spurious readiness
notifications on occasion, I agree.  Then /dev/epoll can easily fulfill
this by signaling readiness on everything at registration; more
accurate notifications could be added later as an optimization.

- Dan

