Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVLFX1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVLFX1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLFX1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:27:01 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58018
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030291AbVLFX1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:27:00 -0500
Date: Tue, 06 Dec 2005 15:27:04 -0800 (PST)
Message-Id: <20051206.152704.82461039.davem@davemloft.net>
To: greg@kroah.com
Cc: felipe.alfaro@gmail.com, fw@deneb.enyo.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051206174714.GE3084@kroah.com>
References: <87psoapa8t.fsf@mid.deneb.enyo.de>
	<6f6293f10512060855p79fb5e91ke6fca33f96cb1750@mail.gmail.com>
	<20051206174714.GE3084@kroah.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Tue, 6 Dec 2005 09:47:14 -0800

> On Tue, Dec 06, 2005 at 05:55:42PM +0100, Felipe Alfaro Solana wrote:
> > > There might be some subtle changes in the netfilter/routing
> > > interaction which break user configurations, but this still being
> > > tracked down (and maybe the any behavior is fine because it's
> > > unspecified; hard to tell).
> > 
> > Yeah! For example, the first datagram triggering an IPSec SA is always
> > lost (instead of being queued until the IPSec SA has been
> > established).
> > 
> > For example, try pinging the IPSec SA peer for the very first time and
> > the first ICMP datagram will always return "resource currently
> > unavailable" and, of course, will get lost.
> > 
> > BTW this works perfectly under *BSD and Mac OS X.
> 
> Do the network kernel developers know about this issue?  And if so, what
> have they said about it?

It's on the TODO list, known problem with not an easy solution.

BTW, BSD doesn't do any better, the KAME BSD ipsec stack drops the
initial datagram just like we do.
