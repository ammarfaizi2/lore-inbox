Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbTJJA4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJJAzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:55:55 -0400
Received: from palrel13.hp.com ([156.153.255.238]:14795 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262703AbTJJAzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:55:49 -0400
Date: Thu, 9 Oct 2003 17:55:48 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Net mailing list <linux-net@vger.kernel.org>
Subject: Re: Wireless Network Maintainer?
Message-ID: <20031010005548.GA3573@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote :
> 
> Is there _anyone_ responsable for the wireless (802.11*) drivers in the
> Linux kernel?

	Yes, the individual driver authors. Either check the names in
the source code or check my Howto.

>    - easy interface = support for wireless tools

	Can't agree me, but I'm biased. This is slowly improving.

>    - compatibility with 2.5/2.6 modul interface

	Wireless drivers included in kernel 2.6.X are already compatible.

>    - support for AP-Master/AP/Ad-Hoc/Monitor Modus (like HostAP can do)

	There is two aspect there.
	First, I want the HostAP driver to be included in 2.6.X, and
I'm trying to make this happen.
	Second, Master and Monitor mode can be implemented only in
drivers for which the necessary hardware documentation is available,
which means only a subset of them.

>   - device naming scheme should be wlanX -> easier to see what it is

	There are pros and cons to that. Personally I prefer the
approach taken by the aironet driver (ethX + wifiX). The interface the
driver present to the kernel is *really* an Ethernet interface.
	If you really want easy identification, we could take the *BSD
approach where every driver use it's own unique device name.

>   - support for external encryption (kernel modules/user space) like WLSec

	Let's not reinvent the wheel again. What's wrong with IPsec ?
If you want to go that route, at least follow one of the upcomming
standard (802.1x, WPA, ...).

	Jean
