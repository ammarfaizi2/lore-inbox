Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTGCOUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTGCOUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:20:11 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9413 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263295AbTGCOUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:20:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Fri, 4 Jul 2003 00:34:49 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
References: <200307021823.56904.kernel@kolivas.org> <200307032221.55773.kernel@kolivas.org> <200307031627.11299.phillips@arcor.de>
In-Reply-To: <200307031627.11299.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307040034.49102.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003 00:27, Daniel Phillips wrote:
> On Thursday 03 July 2003 14:21, Con Kolivas wrote:
> > Theory? uh erm it's rather involved but basically instead
> > of working off the accumulated sleeping ticks gathered in ten seconds it
> > works on the accumulated sleeping ticks gathered till it wakes up. It has
> > non linear semantics to cope with the fact that you cant accumulate 10
> > seconds worth of ticks (for example) if only 10 seconds has passed
> > (likewise for less time). Also idle tasks are no longer considered fully
> > interactive but idle and receive no boost or penalty. Finally they all
> > start with some sleep ticks inherited by their parent as though they have
> > been running for 1 second at least.
>
> I'm still pretty much in the dark after that.  It says something about your
> patch, but it doesn't say much about the problem you're solving, i.e.,
> what's the Context?  (pun intended)

Basically? Who gets to preempt who and for how long. The interactivity 
estimator should decide that the correct task is interactive and get a 
dynamically higher priority and larger timeslice. Is this what you're asking?

Con

