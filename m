Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSJOWhl>; Tue, 15 Oct 2002 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSJOWgT>; Tue, 15 Oct 2002 18:36:19 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:63216 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264800AbSJOWf2>; Tue, 15 Oct 2002 18:35:28 -0400
Date: Tue, 15 Oct 2002 18:41:23 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015184123.J16156@redhat.com>
References: <Pine.LNX.4.44.0210151521090.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9859.5060005@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC9859.5060005@netscape.com>; from jgmyers@netscape.com on Tue, Oct 15, 2002 at 03:36:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 03:36:09PM -0700, John Gardiner Myers wrote:
> Nonetheless, the requirement for user space to test the condition after 
> the registration, not before, is subtle.  A program which does these in 
> the wrong order is still likely to pass QA and will fail in production 
> in a way that will be difficult to diagnose.  There is no rational 
> reason for the kernel to not test the condition upon registration.

I suppose one way of getting the async poll code up to snuff would be to 
cache the poll registration in the file descriptor.  Alternatively, the 
iocb could simply persist until it is cancelled or a refire is permitted 
(so that the event queue does not get overrun).  Would you care to try 
crunching the numbers with polltest on 2.5?

		-ben
-- 
"Do you seek knowledge in time travel?"
