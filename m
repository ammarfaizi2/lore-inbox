Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWHaWnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWHaWnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWHaWnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56966 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932279AbWHaWnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:43:03 -0400
Date: Thu, 31 Aug 2006 15:42:48 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060831224248.GA13990@kroah.com>
References: <20060830062338.GA10285@kroah.com> <44F5C5E0.4050201@gmail.com> <20060830175250.GA6258@kroah.com> <44F6164F.6000709@gmail.com> <20060831001742.GB26265@kroah.com> <44F6E30E.7010501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F6E30E.7010501@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 05:24:30PM +0400, Manu Abraham wrote:
> Usually in the typical application we have (where latency is an issue),
> most probably many of the people have a saturated PCI bus. In most
> cases, the IPTV guys have such a scenario. Say > 6 or 7 DVB adapters and
> the latency goes very high.

Sure, when you are pushing your hardware to the maximum, you should
expect issues like this.  I agree we should do as best as we can for
things like this, but when you over-subscribe your PCI bus by doing
something like this, I really recommend just buying some hardware that
will work better for you (separate PCI busses, etc.  The hardware is out
there to do this properly.)

> What i have seen is that when the bus gets saturated, the CPU usage
> shoots of rather abnormally.

As is to be expected.

> When the latency goes higher, the resultant stream is useless and
> packets needs to be dropped, eventually that results in Transport
> Stream discontinuities.

Sure, that's understandable.

> Currently we already have a latency issue, based on the loud cries
> from some people.

Trying to do things the hardware is not ment to do, should not result in
cries from users :)

thanks,

greg k-h
