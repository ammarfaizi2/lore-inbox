Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131565AbRADVAZ>; Thu, 4 Jan 2001 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135315AbRADVAN>; Thu, 4 Jan 2001 16:00:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135219AbRADVAA>; Thu, 4 Jan 2001 16:00:00 -0500
Date: Thu, 4 Jan 2001 15:59:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: egger@suse.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <20010104213355.707A651AA@Nicole.muc.suse.de>
Message-ID: <Pine.LNX.3.95.1010104155136.18796A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001 egger@suse.de wrote:

> On  4 Jan, Richard B. Johnson wrote:
> 
> > A mobile-phone that runs out of battery power will also  lose all the
> > phone numbers you have stored, etc. The same is true for most all
> > embedded systems that save data.
> 
>  In your world maybe. I would be quite pissed if my mobile phones lost 
>  the stored numbers every time they run out of power. Nearly all embedded 
>  devices nowadays keep their settings without power; be it a satellite
>  receiver, a PBX, a fax machine or a coffee brewer. 

Well they do! It's just not allowed for us (the users) to know that they
__didn't__ run completely out of power!  If the thing is so dead
that it won't recharge, it still has 'power' (enough to keep static RAM
alive). Just remove the battery, wait about 120 seconds for a capacitor
to discharge,  and, zap, no more stored phone numbers. Static RAM with
an electrolytic capacitor, isolated with a diode, takes so little power
that you can normally change defective batteries if you don't take
too long.

> 
> > This means that the data-base
> > software has to roll-back and redo the temporarily-lost updates
> > when it restarts. It uses the journal to accomplish this. As
> > N-seconds gets smaller, the overhead necessary to maintain data
> > consistency gets greater, so there are trade-offs.
> 
>  And depending on the application they may really be worth it.
> 
> > A journaling file-system also needs some number to show the
> > order of operations so that roll-backs and restarts work.
> > Unfortunately, the systems that I have seen all use time for
> > the number! You don't want time to reconstruct 'order'. You
> > need a number that represents 'order'. Time is not your friend.
> 
>  Since the metadata has to be sync anyway what about using a
>  normal transaction counter?
> 

Correct!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
