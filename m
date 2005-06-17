Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVFQTmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVFQTmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVFQTkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:40:06 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:147 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262080AbVFQTjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:39:40 -0400
X-ORBL: [69.107.32.110]
From: David Brownell <david-b@pacbell.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: usbnet ethernet duplex issue?
Date: Fri, 17 Jun 2005 12:39:24 -0700
User-Agent: KMail/1.7.1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <20050617192715.GK27572@waste.org>
In-Reply-To: <20050617192715.GK27572@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506171239.25258.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 June 2005 12:27 pm, Matt Mackall wrote:
> 
> So the question is, what's up with duplex? Everything I can find about
> the hardware (including the ASIX datasheet) claims it's full-duplex
> capable but aside from the error counters, it's really behaving like a
> half-duplex device.

Well, USB itself is half duplex, but that wouldn't explain the issue
you're seeing.  Maybe David Hollis or Phil Chang, who've both worked
with the ASIX parts, can cast some light on their quirks.  This is
on a 2.6 kernel, I hope ... 2.4 kernels have packet queues a bit too
high up in the stack to get any real I/O overlap.

I know that when I've done "ttcp" Linux-to-Linux using a net2280 PCI
card [1] using CDC Ethernet protocols, I can get a bidirectional
transfer rate of around 25 Mbyte/sec (maybe a bit more, I forget;
that's untuned), so the bottleneck isn't the network or USB stacks.

- Dave

[1] http://store.yahoo.com/plxtech/net2280evb.html
