Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262984AbTCLAQv>; Tue, 11 Mar 2003 19:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCLAPF>; Tue, 11 Mar 2003 19:15:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32005 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261729AbTCLAOm>; Tue, 11 Mar 2003 19:14:42 -0500
Date: Tue, 11 Mar 2003 16:23:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Hemminger <shemminger@osdl.org>
cc: David Miller <davem@redhat.com>, Robert Love <rml@tech9.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
Subject: Re: [PATCH] (0/8) replace brlock with RCU
In-Reply-To: <1047428032.15874.87.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0303111622260.2709-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Mar 2003, Stephen Hemminger wrote:
> 
> The following sequence of patches replaces the remaining use of brlock
> with RCU.  Most of this is fairly straightforward. The unregister functions
> use synchronize_kernel(), perhaps there should be a special version to
> indicate sychronizing with network BH. 
>
> Comments?

I'm not going to take this directly, but if it passes muster with David, 
I'm happy.  The fewer locking primitives we need, the better, and brlocks 
have had enough problems that I wouldn't mind getting rid of them.

		Linus

