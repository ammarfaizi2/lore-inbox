Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTGBQ14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTGBQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:27:56 -0400
Received: from smtp3.brturbo.com ([200.199.201.47]:62676 "EHLO
	smtp3.brturbo.com") by vger.kernel.org with ESMTP id S265115AbTGBQ1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:27:49 -0400
Subject: Re: [BENCHMARK] O1int with contest
From: Roberto Orenstein <orenstein@brturbo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307021624.32749.kernel@kolivas.org>
References: <1057120014.7919.23.camel@localhost.localdomain>
	 <200307021624.32749.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057164133.1318.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jul 2003 13:42:18 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-02 at 03:24, Con Kolivas wrote:
> On Wed, 2 Jul 2003 14:26, Roberto Orenstein wrote:
> > Hi guys,
> >
> > Here are some numbers from three kernels tested on my home machine.
> > All threes are 2.5.73 based.
> > Vanilla is a plain one, O1int-0307020011 is the latest (as I last
> > checked) O1int patch w/o the granularity patch, and
> > O1int-granu-0307020011 is the former with granularity.
> 
> Thanks for doing these.
> 
> > One can see that with granularity, the kernel compile suffers a bit, but
> > the response is usually high. In my machine, this was the kernel with
> > the best responsiveness.
> 
> Can you please describe your experiences? The more feedback I get the more I 
> can get it working well.
> 
Well, basically I load the machine with some make -j nuts_number_here,
and I do some other things. The vanilla kernel always behaves badly,
with things like switching windows, loading web pages taking a visible
amount of time to get some cpu attention. The others always win. I mean,
for every load, ranging from a make -j5 to a make -j25 the system
_feels_ better than vanilla. With granularity, it was quite noticeable
(but the kernel compiles were noticeable longer too - some you win and
some you loose :-).
As I said to you on IRC, I wasn't able to make xmms skip with any
kernels (does anyone have a recipe for this?), which I guess is the
issue that started this thread.
The only issue I had was with app startup time (although starting a new
X session was indeed faster - strange).

> > Each kernel was run once, except O1int-0307020011 with three iterations.
> > This was the first I tested, and as soon I noticed the time it took, I
> > decided to run once the others 8). Maybe this has some bad influence on
> > the results. I appreciate any comments...
> 
> Ok well here is my summary of the situation. My patch has virtually no effect 
> on contest results (except perhaps io_other). This is good because my earlier 
> attempts did affect it, and possibly starved some of the loads. Dare I say 
> it, contest is not very good at picking up _these_ sort of scheduler tweaks 
> unless they do something wrong. Sorry if my system responsiveness benchmark 
> doesn't show this effect; I think they're different. This is more about 
> picking the right thing to give preference to. There's a long discussion in 
> that, but I'll try not to get into it.

Well, if things doesn't get worse, it's already a start, right? :-)
In fact I believe it's moving forward. It feels clearly better than
plain 2.5.73, but I don't know if others share the same view. My tests
weren't very scientific nor realistic, it's just a matter of 'looks
good'. Although I think 'feels good' is sometimes better than a lot of
numbers. If there's a way to get some precise numbers, let me know of
it. I thought that contest was a good choice. 

> 
> By the way it doesn't look like your dbench in dbench load actually worked.
Dunno what happened, I've Followed All The Instructions(TM). I'll look
at this later.

> 
> O1int still remains a work in progress.
I'll test your latest patch later to see the improvements. Should I run
another contest on it or doesn't make any difference?

regards,
Roberto

