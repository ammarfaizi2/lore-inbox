Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263369AbTC3CJu>; Sat, 29 Mar 2003 21:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbTC3CJu>; Sat, 29 Mar 2003 21:09:50 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:56087 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S263369AbTC3CJt>;
	Sat, 29 Mar 2003 21:09:49 -0500
To: Thomas Backlund <tmb@iki.fi>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <0d0001c2f616$6a678dc0$9b1810ac@xpgf4> (Thomas Backlund's
 message of "Sat, 29 Mar 2003 19:12:25 +0200")
References: <20030328145159.GA4265@werewolf.able.es>
	<20030328124832.44243f83.akpm@digeo.com>
	<20030328230510.GA5124@werewolf.able.es>
	<20030328151624.67a3c8c5.akpm@digeo.com>
	<20030329004630.GA2480@werewolf.able.es>
	<0d0001c2f616$6a678dc0$9b1810ac@xpgf4>
Date: Sun, 30 Mar 2003 04:21:06 +0200
Message-ID: <86y92xh9wt.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "thomas" == Thomas Backlund <tmb@iki.fi> writes:

thomas> ----- Original Message -----
thomas> From: "J.A. Magallon" <jamagallon@able.es>
thomas> |
thomas> | So, 3 options:
thomas> | - the 905C goes to trashcan
thomas> | - the driver fails to initialize something (I dont trust this...)
thomas> | - winblows messed the card eeprom...any way to tidy it up again ?
thomas> |
thomas> | Thanks everybody...
thomas> |
thomas> | --
thomas> | J.A. Magallon <jamagallon@able.es>      \                 Software is
thomas> like sex:
thomas> | werewolf.able.es                         \           It's better when
thomas> it's free
thomas> | Mandrake Linux release 9.1 (Bamboo) for i586
thomas> | Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

thomas> Since you have MDK 9.1, could you try the 3rdparty/3c90x module from
thomas> mdk kernel-source and see if it works...
thomas> It is 3Com's own driver... that is supposed to work with that card...

thomas> If it won't work, maybe it's the card that is broken... messed up...
thomas> If it works, the bug is in the 3c59x module...

In my experience, that bug is related with acpi.  In a kernel compiled
without acpi, the card works perfectly, in a kernel compiled with acpi
it depend on the phase of the moon and similar things :(

The driver for some reason sets too much 1.  I have one of my machines
conected using dhcp, and it almost never got the right address the
first boot (a reset _usually_ fix the problem, not always).  Some
times, only some bits are set in the mac address, I think that a
couple of times, I have got a MAC with all FF in the address.  

Worse still is the fact, that sometimes it is not the MAC address what
is afected, it is also the vendor ip/product id, that makes that the
driver is not recognized by the driver module.

I have tried both, the standard driver and the 3com "official" driver,
both have that problem.  I already informend Andrew Grover about the
problem, but he is not sure what is happening.

Later, Juan "wondering what sane network card's are still on the market".

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
