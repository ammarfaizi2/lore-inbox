Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135305AbRDRUVq>; Wed, 18 Apr 2001 16:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135304AbRDRUVh>; Wed, 18 Apr 2001 16:21:37 -0400
Received: from m311-mp1-cvx1a.col.ntl.com ([213.104.69.55]:42368 "EHLO
	[213.104.69.55]") by vger.kernel.org with ESMTP id <S135297AbRDRUVY>;
	Wed, 18 Apr 2001 16:21:24 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Let init know user wants to shutdown
Cc: <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
        <apenwarr@worldvisions.ca>
In-Reply-To: <E14pyHg-0005cJ-00@the-village.bc.nu>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 21:21:14 +0100
In-Reply-To: Alan Cox's message of "Wed, 18 Apr 2001 21:10:37 +0100 (BST)"
Message-ID: <m2oftu3qo5.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > willing to exercise this power. We would not break compatibility
> > with any std kernel by instead having a apmd send a "reject all"
> > ioctl instead, and so deal with events without having the pressure
> > of having to reject or accept them, and let us remove all the veto
> > code from the kernel driver. Or am I missing something?
> 
> That sounds workable. But the same program could reply to the events
> just as well as issue the ioctl 8)

Having more than one program holding the veto on each event is a bit
of a hassle. Keeping track of "replies" is also a bit of a
hassle. It'd be simpler to let userspace handle everything in line
with e.g. the ACPI power button press, and suspend or turn off the
machine in the normal manner.

[...]

-- 

	http://www.penguinpowered.com/~vii
