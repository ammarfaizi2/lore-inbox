Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310128AbSCPHmZ>; Sat, 16 Mar 2002 02:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310130AbSCPHmO>; Sat, 16 Mar 2002 02:42:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310128AbSCPHl7>; Sat, 16 Mar 2002 02:41:59 -0500
Date: Fri, 15 Mar 2002 23:40:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Anders Gustafsson <andersg@0x63.nu>, <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <3C92AD1F.30909@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Jeff Garzik wrote:
> 
> I wonder if mochel already code for this, or has thought about this... 
>  Just like suspend, IMO we ideally should use the device tree to 
> shutdown the system, agreed?

Ideally we should, yes. Although if we really turn off power, it doesn't 
much matter.

> Further, I wonder if the reboot/shutdown notifiers can be replaced with 
> device tree control over those events...

This is what I want. Those reboot/shutdown notifiers are completely and 
utterly buggy, and cannot sanely handle any kind of device hierarchy.

		Linus

