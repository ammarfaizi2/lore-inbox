Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135259AbRADUfB>; Thu, 4 Jan 2001 15:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRADUev>; Thu, 4 Jan 2001 15:34:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22538 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135259AbRADUel>;
	Thu, 4 Jan 2001 15:34:41 -0500
Date: Thu, 4 Jan 2001 21:31:46 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010104140542.17050A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010104213355.707A651AA@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jan, Richard B. Johnson wrote:

> A mobile-phone that runs out of battery power will also  lose all the
> phone numbers you have stored, etc. The same is true for most all
> embedded systems that save data.

 In your world maybe. I would be quite pissed if my mobile phones lost 
 the stored numbers every time they run out of power. Nearly all embedded 
 devices nowadays keep their settings without power; be it a satellite
 receiver, a PBX, a fax machine or a coffee brewer. 

> This means that the data-base
> software has to roll-back and redo the temporarily-lost updates
> when it restarts. It uses the journal to accomplish this. As
> N-seconds gets smaller, the overhead necessary to maintain data
> consistency gets greater, so there are trade-offs.

 And depending on the application they may really be worth it.

> A journaling file-system also needs some number to show the
> order of operations so that roll-backs and restarts work.
> Unfortunately, the systems that I have seen all use time for
> the number! You don't want time to reconstruct 'order'. You
> need a number that represents 'order'. Time is not your friend.

 Since the metadata has to be sync anyway what about using a
 normal transaction counter?

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
