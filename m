Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135646AbREBQxD>; Wed, 2 May 2001 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135650AbREBQwx>; Wed, 2 May 2001 12:52:53 -0400
Received: from m213-mp1-cvx1a.col.ntl.com ([213.104.68.213]:21634 "EHLO
	[213.104.68.213]") by vger.kernel.org with ESMTP id <S135645AbREBQwj>;
	Wed, 2 May 2001 12:52:39 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: <sfr@canb.auug.org.au>, <linux-laptop@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <apenwarr@worldvisions.ca>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pqYS-0004Y3-00@the-village.bc.nu>
	<m27l0i58i3.fsf@boreas.yi.org.> <20010420190227.B905@bug.ucw.cz>
From: John Fremlin <chief@bandits.org>
Date: 02 May 2001 17:52:26 +0100
In-Reply-To: <20010420190227.B905@bug.ucw.cz>
Message-ID: <m27kzzae2d.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> > > > I'm wondering if that veto business is really needed. Why not reject
> > > > *all* APM rejectable events, and then let the userspace event handler
> > > > send the system to sleep or turn it off? Anybody au fait with the APM
> > > > spec?
> > > 
> > > Because apmd is optional
> > 
> > The veto stuff only comes into action, iff someone has registered as
> > willing to exercise this power. We would not break compatibility with
> > any std kernel by instead having a apmd send a "reject all" ioctl
> > instead, and so deal with events without having the pressure of having
> > to reject or accept them, and let us remove all the veto code from the
> > kernel driver. Or am I missing something?
> 
> No, this looks reasonable.

What do you think Stephen and Avery? Are you happy with this idea?

If anybody wants to test it, my latest pmevent patch will reject *all*
APM events it can. It would be easy to adapt that to turn on and off
with an ioctl. I am happy to do that if Stephen would accept
it. (Personally would like it if events were rejected by default but
that breaks backward compatibility and there is always someone who
would get bitten.)

The latest pmevent patch (v3) with various APM cleanups is available
at

        http://ape.n3.net/programs/linux/offbutton/download

Note that it currently shares no code with the pmpolicy patch.
For more information see

        http://ape.n3.net/programs/linux/offbutton/

-- 

	http://ape.n3.net
