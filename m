Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311549AbSCNGnQ>; Thu, 14 Mar 2002 01:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311553AbSCNGnN>; Thu, 14 Mar 2002 01:43:13 -0500
Received: from bitmover.com ([192.132.92.2]:26526 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311549AbSCNGmz>;
	Thu, 14 Mar 2002 01:42:55 -0500
Date: Wed, 13 Mar 2002 22:42:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020313224255.F9010@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Greear <greearb@candelatech.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C904437.7080603@candelatech.com>; from greearb@candelatech.com on Wed, Mar 13, 2002 at 11:33:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 11:33:27PM -0700, Ben Greear wrote:
> Can you plz tell me (us) what the bk clone command is?
> 
> I tried:
> 
>   bk clone bk://linux24.bkbits.net//linux-2.4
> 
> and
> 
>   bk clone bk://linux24.bkbits.net///linux-2.4

Hi, Linus & Marcelo agreed that the right place for this is

	bk://linux.bkbits.net/linux-2.4

and I just put it there, let me know if that doesn't work.

Also, if you have a linux-2.5 BK tree, you can save yourself a lot of 
bandwidth by doing the following:

	bk clone -rv2.4.18-pre8 linux-2.5 linux-2.4
	cd linux-2.4
	bk parent bk://linux.bkbits.net/linux-2.4
	bk pull

That will get you back to the baseline you should already have and 
then just update your tree with what Marcelo added recently.

You don't have to do that, and for those of you with fast DSL lines you
can skip, I don't care, but if you are trying to get a 2.4 tree over a
modem, this is much much faster.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
