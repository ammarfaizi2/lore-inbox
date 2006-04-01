Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWDAAcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWDAAcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDAAcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:32:04 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:57481 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932366AbWDAAcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:32:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Staircase test patch
Date: Sat, 1 Apr 2006 10:31:41 +1000
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Thorsten Will <thor_w@arcor.de>,
       linux list <linux-kernel@vger.kernel.org>
References: <200603312307.58507.kernel@kolivas.org> <200604010917.09413.kernel@kolivas.org> <442DC7DB.10406@bigpond.net.au>
In-Reply-To: <442DC7DB.10406@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604011031.41849.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 10:22, Peter Williams wrote:
> Con Kolivas wrote:
> > On Saturday 01 April 2006 07:31, Thorsten Will wrote:
> >> On Friday 31 March 2006 23:07 +1000, Con Kolivas wrote:
> >>> Hi Thorsten et al
> >>
> >> Hi, Con.
> >>
> >>> Thorsten could you please test to see if this fixes the problem for
> >>> you?
> >>
> >> Oh boy, oh boy, oh boy.
> >>
> >> Against a bash loop:
> >> |# dd bs=1M count=2048 </dev/hdb >/dev/null
> >> |2048+0 records in
> >> |2048+0 records out
> >> |2147483648 bytes transferred in 35.497603 seconds (60496582 bytes/sec)
> >>
> >> Yes! Success! And the crowd goes wild! :-)
> >>
> >> I think you finally nailed it. Thank you so much!
> >
> > No, thank _you_ for bringing it to my attention and testing :)
>
> Should I apply this to staircase in PlugSched?

I plan to make staircase v15 which is just this change, which would then need 
to be resunc with plugsched. Unfortunately this needs code in 
account_system_time which is not open to the schedulers in plugsched 
currently so it needs more plugsched code to go in. I suspect other 
schedulers may want to hook into this function, but I know you're currently 
busy with smp nice to hack this in. I may look at doing it myself when I have 
time if you don't have time.

Cheers,
Con
