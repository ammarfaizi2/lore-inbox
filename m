Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRHVRhY>; Wed, 22 Aug 2001 13:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272059AbRHVRhO>; Wed, 22 Aug 2001 13:37:14 -0400
Received: from [209.202.108.240] ([209.202.108.240]:38673 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S272055AbRHVRg7>; Wed, 22 Aug 2001 13:36:59 -0400
Date: Wed, 22 Aug 2001 13:36:57 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: adding accuracy to random timers on PPC - new config option or
 runtime  overhead?
In-Reply-To: <3B83EC7B.B10F59C6@nortelnetworks.com>
Message-ID: <Pine.LNX.4.33.0108221335000.12521-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Chris Friesen wrote:

>
> I'm looking at putting in PPC-specific code in add_timer_randomness() that would
> be similar to the x86-specific stuff.
>
> The problem is that the PPC601 uses real time clock registers while the other
> PPC chips use a timebase register, so two different versions will be required.
> Should I try and identify at runtime which it is (which would be extra
> overhead), or should I add another config option to the kernel?
>
> Thanks,
>
> Chris

How about determining which one to use at boot time? That way there's no
overhead, and there's no need to have yet another config option which probably
doesn't need to be there.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

