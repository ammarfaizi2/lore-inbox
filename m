Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTGBCsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGBCsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:48:55 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:62080 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264629AbTGBCsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:48:54 -0400
Date: Tue, 1 Jul 2003 22:37:39 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: CarlosRomero <caberome@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Shawn Starr <spstarr@sh0n.net>
Subject: Re: simple pnp bios io resources bug makes  system unusable
Message-ID: <20030701223739.GB19402@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	CarlosRomero <caberome@bellsouth.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Shawn Starr <spstarr@sh0n.net>
References: <3F012202.4010303@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F012202.4010303@bellsouth.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 01:54:10AM -0400, CarlosRomero wrote:
> my one line patch just skips an io registration with a simple sanity check.
> never once have i heard a device with an ioport of 0x0.

AT DMA controller as stated in my other message, is one example.

> question is why it happens and only once.

It only happens once because in 99% of cases the entire device is disabled,
not just an individual range.

> (also noticing cutoff in /sys/devices/pci0/*/name)

There is a hard limit for device name length, see include/linux/device.h.
That is probably the cause.

Thanks,
Adam
