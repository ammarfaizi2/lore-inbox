Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbRFZWvf>; Tue, 26 Jun 2001 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbRFZWvY>; Tue, 26 Jun 2001 18:51:24 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:63366 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S265143AbRFZWvN>; Tue, 26 Jun 2001 18:51:13 -0400
Date: Tue, 26 Jun 2001 15:48:09 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Stefan Hoffmeister <lkml.2001@econos.de>
cc: Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <qn1ijt06guu1014p6om26opk7k5933kb7i@4ax.com>
Message-ID: <Pine.LNX.4.33.0106261547280.29221-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Stefan Hoffmeister wrote:

> : On Tue, 26 Jun 2001 18:42:56 -0300 (BRST), Rik van Riel wrote:
>
> >On Tue, 26 Jun 2001, John Stoffel wrote:
> >
> >> Or that we're doing big sequential reads of file(s) which are
> >> larger than memory, in which case expanding the cache size buys
> >> us nothing, and can actually hurt us alot.
> >
> >That's a big "OR".  I think we should have an algorithm to
> >see which of these two is the case, otherwise we're just
> >making the wrong decision half of the time.
>
> Windows NT/2000 has flags that can be for each CreateFile operation
> ("open" in Unix terms), for instance
>
>   FILE_ATTRIBUTE_TEMPORARY
>
>   FILE_FLAG_WRITE_THROUGH
>   FILE_FLAG_NO_BUFFERING
>   FILE_FLAG_RANDOM_ACCESS
>   FILE_FLAG_SEQUENTIAL_SCAN
>
> If Linux does not have mechanism that would allow the signalling of
> specific use case, it might be helpful to implement such a hinting system?

These flags would be really handy.  We already have the raw device for
sequential reading of e.g. CDROM and DVD devices.

-jwb

