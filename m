Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbRDRVID>; Wed, 18 Apr 2001 17:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135348AbRDRVHx>; Wed, 18 Apr 2001 17:07:53 -0400
Received: from cr5112-a.ktchnr1.on.wave.home.com ([24.112.107.106]:44281 "EHLO
	insight.worldvisions.ca") by vger.kernel.org with ESMTP
	id <S135345AbRDRVHu>; Wed, 18 Apr 2001 17:07:50 -0400
Date: Wed, 18 Apr 2001 17:05:32 -0400
From: Avery Pennarun <apenwarr@worldvisions.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Fremlin <chief@bandits.org>, sfr@linuxcare.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010418170532.A6306@worldvisions.ca>
In-Reply-To: <m27l0i58i3.fsf@boreas.yi.org.> <E14pyHg-0005cJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14pyHg-0005cJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 09:10:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 09:10:37PM +0100, Alan Cox wrote:

> > willing to exercise this power. We would not break compatibility with
> > any std kernel by instead having a apmd send a "reject all" ioctl
> > instead, and so deal with events without having the pressure of having
> > to reject or accept them, and let us remove all the veto code from the
> > kernel driver. Or am I missing something?
> 
> That sounds workable. But the same program could reply to the events just
> as well as issue the ioctl 8)

AFAICT some APM BIOSes get impatient if you don't acknowledge/reject the
requests fast enough, and start to go bananas.  By always rejecting requests
and then making user requests instead at some time later, we might eliminate
this problem (or just cause new ones).

Also, I don't think the "critical suspend" message can be rejected at all,
so it would have to be a special case where currently I don't think it's too
bad.

Have fun,

Avery
