Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312826AbSDOFSg>; Mon, 15 Apr 2002 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDOFSf>; Mon, 15 Apr 2002 01:18:35 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.41.41]:34315 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S312826AbSDOFSf>; Mon, 15 Apr 2002 01:18:35 -0400
Date: Mon, 15 Apr 2002 01:18:34 -0400
From: xystrus <xystrus@haxm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Memory Leaking. Help!
Message-ID: <20020415011834.B16804@pizzashack.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16wu4J-00057Y-00@the-village.bc.nu> <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 10:28:00AM +1000, ivan wrote:
> That was 4 GB not 2.
> 
>  No, I do not. That is why I asked is there a way to find out what is 
> eating ram. I am not sure if this a leakage. I am only a paranoid 
> sysadmin. 
> 

I think you said this was a server, didn't you?

You neglected to mention that you're running X and Nautilus on this
server.  You probably don't need this stuff running on a server, and
it is chewing up a good amount of RAM.  If you don't absolutely need
X, try bringing the system up in run level 3 and see if your problem
disappears...

Memory usage (as reported below) of named looks fine.

> named      908  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 

This is probably a big waste:

> root      5765  0.2  0.2 17664 10584 ?       S<   09:36   0:07 /etc/X11/X 
> :0
> root      5818  0.0  0.2 40124 11068 ?       S    09:36   0:01 nautilus 
> start-he
> root      5838  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 
> start-he
> root      5839  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 
> start-he
> root      5840  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 

[etc. snipped]

You also seem to have someone on the system running win4lin and
multiple instances of adobe acrobat reader.  If this is really a
server, perhaps it would be better to have them run those things
elsewhere...

Hope that helps

-- 
Xy
xystrus@haxm.com

