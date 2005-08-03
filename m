Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVHCXij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVHCXij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVHCXij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:38:39 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:25544 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261622AbVHCXii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:38:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] [ANNOUNCE] Interbench v0.26
Date: Thu, 4 Aug 2005 09:34:19 +1000
User-Agent: KMail/1.8.1
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Jake Moilanen <moilanen@austin.ibm.com>, linux-kernel@vger.kernel.org
References: <200508031758.31246.kernel@kolivas.org> <42F15264.20409@bigpond.net.au> <200508040925.57577.kernel@kolivas.org>
In-Reply-To: <200508040925.57577.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040934.19498.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 09:25 am, Con Kolivas wrote:
> On Thu, 4 Aug 2005 09:25 am, Peter Williams wrote:
> > Con Kolivas wrote:
> > > On Wed, 3 Aug 2005 22:01, Gabriel Devenyi wrote:
> > >>You haven't quite completely fixed the SD calculations it seems:
> > >>
> > >>
> > >>--- Benchmarking simulated cpu of Gaming in the presence of
> > >> simulated--- Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
> > >>None       2.44 +/- nan         48.6            98.7
> > >>Video      12.8 +/- nan         55.2              89
> > >>X          89.7 +/- nan          494            52.8
> > >>Burn        400 +/- nan         1004            20.1
> > >>Write      49.2 +/- nan          343            67.2
> > >>Read       4.14 +/- nan         56.7            96.7
> > >>Compile     551 +/- nan         1369            15.4
> > >>
> > >>:(
> > >
> > > I keep trying
> >
> > The problem is a variation of the original one that I pointed out.  The
> > value that's being added to the sum of the squares of the latency is not
> > always the square of the value being added to the latency.
> >
> > Would you like me to fix it and send you a patch?
>
> I fixed that too in what is in front of me (sorry not the one I've released
> it was only clear to me when this report came back) and am still hitting
> some bug somewhere. I've yet to track it down.

Silly me. The gaming emulation doesn't use periodic_schedule so I wasn't 
storing the data anywhere for standard deviation. Will release a fixed 
version soon.

Cheers,
Con
