Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbTCMVLh>; Thu, 13 Mar 2003 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbTCMVLh>; Thu, 13 Mar 2003 16:11:37 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42758 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262543AbTCMVLg>;
	Thu, 13 Mar 2003 16:11:36 -0500
Date: Thu, 13 Mar 2003 22:21:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Rusty Lynch <rusty@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Watchdog-Drivers
Message-ID: <20030313212146.GC679@alpha.home.local>
References: <1046796116.1351.4.camel@vmhack> <20030313232437.A24873@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313232437.A24873@medelec.uia.ac.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Thu, Mar 13, 2003 at 11:24:37PM +0100, Wim Van Sebroeck wrote:
 
> I personnaly think we should go for multiple watchdog_driver devices on the same system.
> (Reason why: suppose you have a multi-processor system where each processor-board would have it's own CPU it's own external cache and it's own watchdog, in this case you would need multiple watchdog devices on the same system).

I have another use for this : for remote management, I'd like to have a
short-time watchdog and a long-time watchdog. The short time watchdog would
avoid remote users to be annoyed by a system hang which takes too long a time
to reboot, while the long one would allow me to recover from a wrong
manipulation in a time shorter than what it takes to get on the remote site :
when I do something risky (network restart, fw...), I simply kill the long
watchdog daemon so that I do my work while the counter still runs. If I shoot
myself in the foot, it will end in a spontaneous reboot. But I don't want the
system to always run on such a slow timer, reason for the second watchdog.

Cheers,
Willy

