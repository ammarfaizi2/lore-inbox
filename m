Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276116AbRI1PU6>; Fri, 28 Sep 2001 11:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRI1PUs>; Fri, 28 Sep 2001 11:20:48 -0400
Received: from hermes.toad.net ([162.33.130.251]:13954 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276116AbRI1PUk>;
	Fri, 28 Sep 2001 11:20:40 -0400
Message-ID: <3BB49543.6A915332@mail.com>
Date: Fri, 28 Sep 2001 11:20:35 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
In-Reply-To: <3BB48A34.E392B7BC@mail.com> <20010928165122.L21524@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> It works, kind of.
> 
> The only remaining problem is that the DMI scan routines are
> called _after_ the PnP BIOS scan, so the is_sony_vaio_laptop
> variable will be always evaluated to 0 in your patch (causing
> the same hang again).

This is unfortunate.  :(

Alan:  Does this mean that we will have to use a new CONFIG_
macro instead of testing is_sony_vaio_laptop?  If so then
I will submit a new patch with "#ifdef CONFIG_SONY_PNPBIOS"s
in it and I'll let you futz with the kernel configuration
files required to set this up.

> After manually changing is_sony_vaio_laptop to 1 the
> patched kernel boots ok, entries in /proc/bus/pnp are present
> (not sure how to test if their contents are corect though).

There should be no numerically named entries in /proc/bus/pnp;
you should see only the "devices" file and the "boot" directory.
You should see numerically named entries in /proc/bus/pnp/boot
for each device.

--
Thomas
