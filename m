Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267549AbSKQSnt>; Sun, 17 Nov 2002 13:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267551AbSKQSnt>; Sun, 17 Nov 2002 13:43:49 -0500
Received: from [202.88.171.30] ([202.88.171.30]:37035 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S267549AbSKQSnt>;
	Sun, 17 Nov 2002 13:43:49 -0500
Date: Mon, 18 Nov 2002 00:16:40 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Matthew Wilcox <willy@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Run timers as softirqs, not tasklets
Message-ID: <20021118001640.A27495@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021117171625.C7530@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021117171625.C7530@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sun, Nov 17, 2002 at 06:20:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 06:20:11PM +0100, Matthew Wilcox wrote:
> 
> Seems to me that the timer code is attempting to replicate the softirq
> characteristics at the tasklet level, which is a little pointless.  This
> patch converts timers to be a first-class softirq citizen.
> 
> Ingo, was there a reason you didn't do it this way to begin with?
> 

I wrote that part of smptimers to run the per-CPU lists from per-CPU
tasklets while porting Ingo's code to 2.5 and Ingo just included it.
At that time, it didn't seem necessary to use up a softirq vector 
when it could be easily done using tasklets.

However it should work fine with softirqs too.

Thanks
Dipankar
