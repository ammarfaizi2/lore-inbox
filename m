Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310346AbSCLB4a>; Mon, 11 Mar 2002 20:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310335AbSCLB4K>; Mon, 11 Mar 2002 20:56:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59153 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310330AbSCLB4E>; Mon, 11 Mar 2002 20:56:04 -0500
Date: Mon, 11 Mar 2002 17:41:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <andersen@codepoet.org>, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D5AF6.8070602@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203111736520.8121-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
> Your first question is really philosophical.  I think that people should
> -not- be able to send undocumented commands through the interface...
>  and in this area IMO it pays to be paranoid.

What if the command is perfectly documented, but only for a certain class
of IBM disks?

Are you going to create a table of every disk out there, along with every
command it can do?

Remember: the kernel driver is a driver for the host controller, yet the
command is for the _disk_. It makes no sense to check for disk commands in
a host controller driver - they are two different things.

It's like checking for icmp messages in a network driver. Do you seriously
propose having network drivers check icmp messages for command validity?

			Linus

