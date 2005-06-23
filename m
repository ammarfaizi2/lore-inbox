Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVFWSjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVFWSjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVFWSey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:34:54 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:43767 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262989AbVFWScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:32:52 -0400
Message-ID: <42BB0027.6030502@am.sony.com>
Date: Thu, 23 Jun 2005 11:32:07 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <pozsy@uhulinux.hu>
CC: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       "Sean M. Burke" <sburke@cpan.org>, trivial@rustcorp.com.au
Subject: Re: PATCH: "Ok" -> "OK" in messages
References: <42985251.6030006@cpan.org> <1117279792.32118.11.camel@localhost.localdomain> <20050528125430.GB3870@ojjektum.uhulinux.hu> <42BAE3B1.5010209@am.sony.com> <20050623165309.GA23548@ojjektum.uhulinux.hu>
In-Reply-To: <20050623165309.GA23548@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>-	putstr("Uncompressing Linux... ");
> >> +	putstr("Linux " UTS_RELEASE);
> >>  	gunzip();
> >> -	putstr("Ok, booting the kernel.\n");
> >> +	putstr("\n");
> >>

� wrote:
>>Language neutrality is not a goal for kernel messages,
>>that I'm aware of.
> 
> Of course this is true, but I think this very one is an exception: this 
> is the only one seen when booting with the "quiet" kernel option or 
> using some shiny bootlogo patches, both of which is common practice 
> among distribution-shipped kernels.
> 
OK, I understand why this one might worth different
consideration.

> 
>>I disagree with this change because
>>it yields a net reduction in understanding what's going
>>on during booting.
> 
> No, it does not yields any reduction. Only the strings itself are 
> changed, not the time they are printed.
This is only true if the words themselves have no meaning or utility.
They do.

> Besides, nobody is interested that actually an uncompress step is in 
> progress, that just works.
This is not true, a developer working on a new board support package
cares whether we're in the decompress step or in the kernel booting step.

New developers unfamiliar with the kernel booting sequence will have
to find out where this message is coming from, when things fail.
Without a unique string to search for, this becomes quite difficult
to find.

In my field, I work with a LOT of developers who are not deeply
familiar with the kernel, but still face these bootup messages.

> And, btw if it fails (the gunzip), it prints 
> an error message anyway iirc.

I'm not sure what happens on gunzip failure, but
I see kernel boot failures quite often during
board bringup, and it's nice to know if you've
passed the decompression phase, etc.  The messages
you propose are much less instructive for the
developer.

However, I will grant that we're not trying to
optimize for the developer, but rather should
be optimizing for the user.  But if we can
do something that is suitable to both, I would
prefer it.  Could we put just a little more
wording back in?

 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
