Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbTCTH0B>; Thu, 20 Mar 2003 02:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbTCTH0A>; Thu, 20 Mar 2003 02:26:00 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:37541 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261407AbTCTHZ7>; Thu, 20 Mar 2003 02:25:59 -0500
Date: Thu, 20 Mar 2003 08:36:52 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: george anzinger <george@mvista.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
In-Reply-To: <3E78E16E.7090602@mvista.com>
Message-ID: <Pine.LNX.4.33.0303200831260.6486-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, george anzinger wrote:

> I found a problem with the last version.  The attached is for
> 2.5.65-1.1171 (i.e. after the other post 2.5.65 changes).  The bug is
> fixed, and the code even simpler here.
>
> The problem in the prior patch was that cascade should return:
> (index +1) &... not  index &...

I haven't had time yet to look into any of the patches more closely,
but ...

> Here I changed the call to cascade() to expect "index" back so it
> checks for 0 instead of 1.  Nice and simple.

... this is what I expected to come out from our simplification and what
made me suspicious against the previous version.
So I'd just guess the patch is fine now.

Tim

