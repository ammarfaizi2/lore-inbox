Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSH3Wd0>; Fri, 30 Aug 2002 18:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSH3WdZ>; Fri, 30 Aug 2002 18:33:25 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36262 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S310190AbSH3WdY>;
	Fri, 30 Aug 2002 18:33:24 -0400
Date: Sat, 31 Aug 2002 00:36:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, jsimmons@transvirtual.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31-serport
Message-ID: <20020831003618.B33615@ucw.cz>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk> <20020830.150359.16679671.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020830.150359.16679671.davem@redhat.com>; from davem@redhat.com on Fri, Aug 30, 2002 at 03:03:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 03:03:59PM -0700, David S. Miller wrote:
>    From: Russell King <rmk@arm.linux.org.uk>
>    Date: Fri, 30 Aug 2002 22:39:11 +0100
> 
>    2. What happens if I open and try to read from this port while something
>       has the serport_ldisc attached?  I suspect that you'll create nice
>       loop of serio devices in serio.c and an infinite loop when you try to
>       traverse the list to remove a different serio device.
>       
> SERIO devices are not meant to be registered as normal TTYs.
> At least I don't do this for any of the Sparc serial ports
> when they are the keyboard/mouse serio device.

No, but using serport.c, you can bind a serio to a tty via a line
discipline, for example if you want a PC serial mouse on /dev/ttyS0 to
talk to sermouse.c via serio. I don't like the approach much, I hope(d) we
could switch somewhere below the tty layer, but it sort of works, and
maybe will have the bugs fixed sooner or later.

-- 
Vojtech Pavlik
SuSE Labs
