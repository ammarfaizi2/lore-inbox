Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTEHWGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEHWGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:06:40 -0400
Received: from palrel12.hp.com ([156.153.255.237]:11679 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262145AbTEHWGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:06:38 -0400
Date: Thu, 8 May 2003 15:19:12 -0700
To: Eli Carter <eli.carter@inet.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: The magical mystical changing ethernet interface order
Message-ID: <20030508221912.GA27904@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030508193245.GA26721@bougret.hpl.hp.com> <3EBACF9D.5070501@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBACF9D.5070501@inet.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 04:43:57PM -0500, Eli Carter wrote:
> Jean Tourrilhes wrote:
> [snip]
> >Randy.Dunlap wrote :
> >
> >>An alternative is to use 'nameif' to associate MAC addresses with
> >>interface names.  See here for mini HOWTO:
> >>
> >> http://www.xenotime.net/linux/doc/network-interface-names.txt
> >
> >
> >	Currently this feels like a kludge, because not fully
> >inegrated, but goes in the right direction.
> >	Actually, it's pretty funny that the original Pcmcia package
> >got it right since the beggining (and Win2k as well), but
> >distributions took a step backward from that when integrating Pcmcia.
> >	My belief is that configuration scripts should be specified in
> >term of MAC address (or subset) and not in term of device name. Just
> >like the Pcmcia scripts are doing it.
> >	And let's go the extra mile : ifconfig should accept a MAC
> >address as the argument instead of a device name. And in the long
> >term, just get rid of device name from the user view.
> 
> Some network devices do not have a mac address on power-up and must be 
> supplied one.
> 
> Eli

	For those devices there is little difference conceptually
between using ifname to bind them to a known name and using ifconfig
to set the MAC address : you need to set the MAC address prior to any
operation, and when it's done, you have a MAC address so you can deal
with it like any other device.
	Anyway, those devices are so rare that I would not optimise
for them, and I would tradeof a bit more sanity for usual device in
exchange to a few complications for unusual devices.
	And I'm also perfectly well aware that some devices such IrDA
devices and PPP devices doesn't have a fixed 48bit address so can't be
handled with the scheme I propose. But those devices are usually
handled in their own way.

	Have fun...

	Jean
