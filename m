Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTFYNkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFYNkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:40:20 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:3235 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264308AbTFYNkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:40:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] 2.5.72-mm3 O(1) interactivity enhancements
Date: Wed, 25 Jun 2003 23:56:21 +1000
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1056368505.746.4.camel@teapot.felipe-alfaro.com> <200306240015.23613.kernel@kolivas.org> <1056394444.587.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056394444.587.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306252356.21814.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003 04:54, Felipe Alfaro Solana wrote:
> On Mon, 2003-06-23 at 16:15, Con Kolivas wrote:
> > For those who aren't familiar, you've utilised the secret desktop weapon:
> >
> > +		if (!(p->time_slice % MIN_TIMESLICE) &&
> >
> > This is not how Ingo intended it. This is my desktop bastardising of the
> > patch. It was originally about 50ms (timeslice granularity). This changes
> > it to 10ms which means all running tasks round robin every 10ms - this is
> > what I use in -ck and is great for a desktop but most probably of
> > detriment elsewhere. Having said that, it does nice things to desktops
> > :-)
>
> I lost the track to Ingo's patch sometime ago, so I borrowed it from
> your latest patchset ;-) It does really nice things on desktops. It
> brings 2.5 to a new life on my 700Mhz laptop.
>
> What impact would have increasing MIN_TIMESLICE from 10 to, let's say,
> 50?

It stops being helpful :) 50 was the default Ingo used but this was far too 
long for say X to be waiting just to get to move the mouse again - this is 
why the mouse movement is so much less jerky with this set to 10.

Con

