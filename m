Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135255AbRDRTLX>; Wed, 18 Apr 2001 15:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135254AbRDRTLE>; Wed, 18 Apr 2001 15:11:04 -0400
Received: from m492-mp1-cvx1c.col.ntl.com ([213.104.77.236]:4224 "EHLO
	[213.104.77.236]") by vger.kernel.org with ESMTP id <S135253AbRDRTK7>;
	Wed, 18 Apr 2001 15:10:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <sfr@linuxcare.com.au>, <linux-kernel@vger.kernel.org>,
        <apenwarr@worldvisions.ca>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pqYS-0004Y3-00@the-village.bc.nu>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 20:10:44 +0100
In-Reply-To: Alan Cox's message of "Wed, 18 Apr 2001 12:55:26 +0100 (BST)"
Message-ID: <m27l0i58i3.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I'm wondering if that veto business is really needed. Why not reject
> > *all* APM rejectable events, and then let the userspace event handler
> > send the system to sleep or turn it off? Anybody au fait with the APM
> > spec?
> 
> Because apmd is optional

The veto stuff only comes into action, iff someone has registered as
willing to exercise this power. We would not break compatibility with
any std kernel by instead having a apmd send a "reject all" ioctl
instead, and so deal with events without having the pressure of having
to reject or accept them, and let us remove all the veto code from the
kernel driver. Or am I missing something?

-- 

	http://www.penguinpowered.com/~vii
