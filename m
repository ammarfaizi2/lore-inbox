Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRC0QoX>; Tue, 27 Mar 2001 11:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131419AbRC0QoQ>; Tue, 27 Mar 2001 11:44:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:24589 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131415AbRC0Qnu>; Tue, 27 Mar 2001 11:43:50 -0500
Message-ID: <3AC0C040.D210354@evision-ventures.com>
Date: Tue, 27 Mar 2001 18:30:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Michel Wilson <michel@procyon14.yi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <NEBBLEJBILPLHPBNEEHIKECICBAA.michel@procyon14.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Wilson wrote:
> 
> > relative ages.  The major flaw in my code is that a sufficiently
> > long-lived
> > process becomes virtually immortal, even if it happens to spring a serious
> > leak after this time - the flaw in yours is that system processes
> 
> I think this could easily be fixed if you'd 'chop off' the runtime at a
> certain point:
> 
> if(runtime > something_big)
>         runtime = something_big;
> 
> This would of course need some tuning. The only thing i don't like about
> this is that it's a kind of 'magical value', but i suppose it's not a very
> good idea to make this configurable, right?

Then after some time runtime becomes allmost irrelevant.
You are basically for what I call normalization by the total 
system uptime.
