Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbUCPQBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCPP63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:58:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51340 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262074AbUCPP4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:56:31 -0500
Date: Tue, 16 Mar 2004 10:58:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dave Jones <davej@redhat.com>
cc: Marc Zyngier <mzyngier@freesurf.fr>,
       Linux kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
In-Reply-To: <20040316142951.GA17958@redhat.com>
Message-ID: <Pine.LNX.4.53.0403161053040.6499@chaos>
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
 <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com>
 <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org> <20040316142951.GA17958@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Dave Jones wrote:

> On Tue, Mar 16, 2004 at 03:09:49PM +0100, Marc Zyngier wrote:
>  > >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
>  >
>  > Dave> Then the probing routine is bogus, it returns 0 when it fails too.
>  >
>  > Uh ? el3_eisa_probe looks like it properly returns an error...
>  >
>  > Or maybe you call a failure not finding a proper device on the bus ?
>
> The damned bus doesn't even exist. If this is a case that couldn't be
> detected, I'd not be complaining, but this is just nonsense having
> a driver claim that its found an EISA device, when there aren't even
> any EISA slots on the board.

There is no way that any software knows about an EISA bus. It
only knows that there is some device at some port. Since a 3c503
was built to go into an 8-bit EISA slot, if one is found it
is assumed to be in such a slot on the EISA bus!

So, if the device doesn't exist there is a problem with the
detection method for the device, not a detection method for
a bus because the bus can't be detected at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


