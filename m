Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVBDSxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVBDSxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbVBDSYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:24:24 -0500
Received: from netblock-66-159-231-38.dslextreme.com ([66.159.231.38]:22201
	"EHLO mail.cavein.org") by vger.kernel.org with ESMTP
	id S266420AbVBDSW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:22:56 -0500
Date: Fri, 4 Feb 2005 10:22:51 -0800 (PST)
From: Richard A Nelson <cowboy@cavein.org>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Shane Hathaway <shane@hathawaymix.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
In-Reply-To: <200502041755.41288.hpj@urpla.net>
Message-ID: <Pine.LNX.4.58.0502041017560.30239@hygvzn-guhyr.pnirva.bet>
References: <200502022148.00045.shane@hathawaymix.org> <200502041755.41288.hpj@urpla.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Hans-Peter Jansen wrote:

> On Thursday 03 February 2005 05:47, Shane Hathaway wrote:
> > The attached patch enhances the kernel's DHCP client support (in
> > net/ipv4/ipconfig.c) to set the interface MTU if provided by the
> > DHCP server. Without this patch, it's difficult to netboot on a
> > network that uses jumbo frames.  The patch is based on 2.6.10, but
> > I'll update it to the latest testing kernel if that would expedite
> > its inclusion in the kernel.

What will this code do at the (increasingly common) misconfigured sites
- many places (hotels, airports, etc) return a MTU of 64... to which the
DHCP3 client faithfully attempts to set, only to receive:
	SIOCSIFMTU: Invalid argument

And is one of the easiest issues I've had during my travels - thankfully
I don't do it all that often; trying to tell the helpdesk folk that
their DHCP server is handing out bogus DNS servers, MTU, even networks
is an exercise in futility.

-- 
Rick Nelson
"Absolutely nothing should be concluded from these figures except that
no conclusion can be drawn from them."
(By Joseph L. Brothers, Linux/PowerPC Project)
