Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311810AbSCNV3S>; Thu, 14 Mar 2002 16:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311807AbSCNV3D>; Thu, 14 Mar 2002 16:29:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46341 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311810AbSCNV2n>; Thu, 14 Mar 2002 16:28:43 -0500
Date: Thu, 14 Mar 2002 13:26:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: John Heil <kerndev@sc-software.com>, <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.3.95.1020314155816.136A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0203141324480.9855-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Mar 2002, Richard B. Johnson wrote:
> 
> Well I can see why he's an EX-Phoenix BIOS developer. A port at 0xed
> does not exist on any standard or known non-standard Intel/PC/AT 
> compatible.

Note that "doesn't exist" is actually a _bonus_. It means that no 
controller will answer to it, which causes the IO to time out, which on a 
regular ISA bus will also take the same 1us. Which is what we want.

Real ports with real controllers can be faster - they could, for example,
be fast motherboard PCI ports and be positively decoded and be faster than
1us.

		Linus

