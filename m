Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135361AbRDRVf5>; Wed, 18 Apr 2001 17:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135358AbRDRVfr>; Wed, 18 Apr 2001 17:35:47 -0400
Received: from m264-mp1-cvx1a.col.ntl.com ([213.104.69.8]:64641 "EHLO
	[213.104.69.8]") by vger.kernel.org with ESMTP id <S135357AbRDRVff>;
	Wed, 18 Apr 2001 17:35:35 -0400
To: Avery Pennarun <apenwarr@worldvisions.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <sfr@linuxcare.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <m27l0i58i3.fsf@boreas.yi.org.>
	<E14pyHg-0005cJ-00@the-village.bc.nu>
	<20010418170532.A6306@worldvisions.ca>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 22:34:28 +0100
In-Reply-To: Avery Pennarun's message of "Wed, 18 Apr 2001 17:05:32 -0400"
Message-ID: <m21yqp51uj.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Avery Pennarun <apenwarr@worldvisions.ca> writes:

> On Wed, Apr 18, 2001 at 09:10:37PM +0100, Alan Cox wrote:
> 
> > > willing to exercise this power. We would not break compatibility with
> > > any std kernel by instead having a apmd send a "reject all" ioctl
> > > instead, and so deal with events without having the pressure of having
> > > to reject or accept them, and let us remove all the veto code from the
> > > kernel driver. Or am I missing something?
> > 
> > That sounds workable. But the same program could reply to the events just
> > as well as issue the ioctl 8)
> 
> AFAICT some APM BIOSes get impatient if you don't acknowledge/reject
> the requests fast enough, and start to go bananas.  By always
> rejecting requests and then making user requests instead at some
> time later, we might eliminate this problem (or just cause new
> ones).

Indeed. Neither proposal has however received wide testing as far as I
know. The userspace ACCEPT/REJECT method was available as a patch from
Stephen for a while though.

> Also, I don't think the "critical suspend" message can be rejected
> at all, so it would have to be a special case where currently I
> don't think it's too bad.

ATM it is a "special case" - we print a message if we try to reject a
critical suspend. However the case is not so special that it requires
more than a line or two ;-)

I don't think there is any cause for concern on that front.

[...]

-- 

	http://www.penguinpowered.com/~vii
