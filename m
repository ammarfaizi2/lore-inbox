Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSKRWEU>; Mon, 18 Nov 2002 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKRWD2>; Mon, 18 Nov 2002 17:03:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12814 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265097AbSKRWC0>;
	Mon, 18 Nov 2002 17:02:26 -0500
Date: Mon, 18 Nov 2002 23:09:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Vergoz Michael <mvergoz@sysdoor.com>
Cc: Michael Knigge <Michael.Knigge@set-software.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx: 8139 isn't working
Message-ID: <20021118220920.GA3636@alpha.home.local>
References: <20021118.10200352@knigge.local.net> <00e701c28ee5$16c501e0$76405b51@romain> <20021118.11265925@knigge.local.net> <015f01c28eed$f112ce10$76405b51@romain> <20021118.11392845@knigge.local.net> <019401c28eef$492bcb50$76405b51@romain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019401c28eef$492bcb50$76405b51@romain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:43:09AM +0100, Vergoz Michael wrote:
> hmmm
> 
> life is strange.....
> 
> i'v the same card as u and it work for me !

That's why you definitely need to feed *REAL* information to Jeff so that he
can find with you what in your patch makes it work for you, and will probably
make it work for Michael and others. Your patch may work because of a side
effect, and may not work on other systems because of other side effects (apic,
irq numbers,...).

None of you have provided even the smallest amount of info. One says "it works
only with this strange patch" and the other one "it doesn't for me even with
your strange patch". Even Windowsians are more precise with their support. How
would you hope that your patch be accepted with such an attitude ?

- does modprobe complain ?
- does modprobe return ?
- do you get an oops ?
- does dmesg show errors or warnings (irq routing conflicts, unsupported chip).
- does the machine lock up hard at load time ?
- does the machine lock up when you set the interface up ?
- does the machine lock up when you start sending ?
- is the link on the board lit ?
- does the machine resolve arp ?
- does the machine show timeouts ?
- what speed are your using it at ? (100 fdx, 100 hdx, 10 hdx...)

And as Jeff said, please read REPORTING-BUGS. A simple lspci could show us that
in fact you have a known-buggy chipset and that your patch is indeed a
workaround for the chipset and not for the NIC.

Thanks in advance,
Willy

