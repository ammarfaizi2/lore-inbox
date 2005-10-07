Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVJGQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVJGQoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbVJGQoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:44:23 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:27927 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030505AbVJGQoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:44:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7HGCatBoKnYjq2jai3VmuR8hfmG0VLJOdFvt6x3YaqJD78YFgv/lk1wbOJRP24HjVaWJ5lbeenPIjSy3E4aDk3EbNpZgKxHYy6UMnWYb5uaedQWtZCWIXVHIS1fXWoSZB/OS8wRRfvKrrgBqTazp3G2qdCjxdHmILWAfjxlgbE=
Message-ID: <5bdc1c8b0510070944p5a09f7f2m4965f3e0ddda21f7@mail.gmail.com>
Date: Fri, 7 Oct 2005 09:44:21 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051007114848.GE857@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
	 <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
	 <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
	 <20051007114848.GE857@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > However, at odd times I still get xruns. For instance one set of xruns
> > came while browsing the web. I was on this page:
>
> > and got 2 xruns:
> >
> > 18:20:06.541 XRUN callback (8).
> > **** alsa_pcm: xrun of at least 3.172 msecs
> > **** alsa_pcm: xrun of at least 0.967 msecs
> > 18:20:07.908 XRUN callback (1 skipped).
> >
> > So, while things are far, far better for me than they were earlier
> > this week, there are still some problems I'd like to get to the bottom
> > of if possible.
>
> one thing i noticed: you have CONFIG_SMP set. Is it a true SMP x64
> system? In any case, could you try without CONFIG_SMP, just to test
> whether the latencies are related to SMP.
>
>         Ingo
>

Hi Ingo,
   OK, I've been running -rt10 for the last couple of hours on a new
kernel without SMP. No xruns so far at 64/2. I'm doing all the normal
stuff. emerge sync, building some code outside of portage, playing
music. Very good so far, but it will likely take 4-6 hours for me to
be more sure saying it was just SMP latencies.

   I see you're putting out -rt updates faster than I can build & test
them so I decided to stick with -rt10 for now to ensure a fair
comparison. I'll catch up with -rt12 or later sometime this evening to
tomorrow.

   Until then, one question. Yesterday I set priorities as such:

Jack - 80
Sound card - 80
1394 drive - 61
SATA drive 60

   What exactly do these numbers mean? If the 1394 drive was a 79
instead of a 61 would it change anything? Or does the system just
prioitize them numerically but operate on the highest numbered request
in which case a 79 vs. 61 wouldn't matter ?

Thanks,
Mark
