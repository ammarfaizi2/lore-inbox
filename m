Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265558AbSJRSVl>; Fri, 18 Oct 2002 14:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbSJRSVl>; Fri, 18 Oct 2002 14:21:41 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:11654 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265558AbSJRSVk>; Fri, 18 Oct 2002 14:21:40 -0400
Date: Fri, 18 Oct 2002 20:27:38 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Robert Love <rml@tech9.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: variable HZ
In-Reply-To: <1034661791.10843.9.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0210182011390.8360-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2002, Robert Love wrote:
> I backported the jiffies_to_clock_t() code from 2.5 to 2.4, mostly just
> for fun.
...
> Oh, and I did not backport 64-bit jiffies yet.

If you would, how would you call the analogous function for 64 bit values?
And the type it returns?

The patches to make the kernel interfaces use the 64 bit jiffies value sit 
in Davej's tree since around 2.5.20-dj3, just waiting for the answer to 
these questions.

jiffies_64_to_clock_t_64() seems a bit lengthy. My current personal 
favourite would be jiffies_64_to_user_HZ(), just returning an u64, so that 
we don't keep on inventing silly types that get used just a very few 
times.

Just my 0.02 euro, though.

Tim

