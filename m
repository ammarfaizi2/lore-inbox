Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSGKQ4u>; Thu, 11 Jul 2002 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSGKQ4t>; Thu, 11 Jul 2002 12:56:49 -0400
Received: from pD952A525.dip.t-dialin.net ([217.82.165.37]:38273 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317858AbSGKQ4r>; Thu, 11 Jul 2002 12:56:47 -0400
Date: Thu, 11 Jul 2002 10:59:31 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: dank@kegel.com
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably
 as small  as possible)
In-Reply-To: <3D2DB5F3.3C0EF4A2@kegel.com>
Message-ID: <Pine.LNX.4.44.0207111056230.3582-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002 dank@kegel.com wrote:

> Then let's increase the interval between the normal periodic clock
> events from 10ms to infinity.  Everything will keep working, as the
> high-resolution timer patch code will schedule timer events as needed --
> but suddenly we'll have power consumption as low as possible, snappier
> performance, and the thousands-of-instances case will no longer have
> this huge drain on performance from periodic timer events that do
> nothing but update jiffiers.

Well, that's the aim.

> OK, so I'm just an ignorant member of the peanut gallery, but
> I'd like to hear a real kernel hacker explain why this isn't
> the way to go.

The only thing that was mentioned yet was the amount of stuff that depends 
on periodic ticks. If we just tick unperiodically, we'd fail for sure, but 
if we make these instances depend on another timer - we won.

I think a good scheduler can handle this and should also be able to 
determine a halfaway optimal tick rate for the current load.

That's a _real_ challenge, guys!

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

