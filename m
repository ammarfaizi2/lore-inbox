Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVHBKyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVHBKyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVHBKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:54:45 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:9901 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261483AbVHBKyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:54:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Tue, 2 Aug 2005 20:54:21 +1000
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org> <200508021739.20347.kernel@kolivas.org> <20050802081512.GI15903@atomide.com>
In-Reply-To: <20050802081512.GI15903@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508022054.22276.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 18:15, Tony Lindgren wrote:
> * Con Kolivas <kernel@kolivas.org> [050802 00:36]:
> > On Tue, 2 Aug 2005 05:17 pm, Tony Lindgren wrote:
> > > But this you can verify by booting to single user mode and then running
> > > pmstats 5, and if ticks is not below 25HZ, there's something in the
> > > kernel polling.
> >
> > I'm removing modules and they don't seem to do anything so I'm not sure
> > what else to try.
>
> If you have 130HZ in single user mode, it's some kernel driver.
> You could printk the the next timer, then grep for that in System.map:

I kept pulling modules and eventually got to 27Hz so something was definitely 
happening.

I need to ask you why you think limiting the maximum Hz is a bad idea? On a 
laptop, say we have set the powersave governor, we have already told the 
kernel we are interested in maximising power saving at the expense of 
performance. Would it not be appropriate for this to be linked in a way that 
sets maximum Hz to some value that maximises power save (whatever that value 
is) at that time?

Cheers,
Con
