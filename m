Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFZLmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFZLmf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFZLmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:42:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44559 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261259AbVFZLmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:42:24 -0400
Date: Sun, 26 Jun 2005 12:42:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-ID: <20050626124219.G14862@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>; from akpm@osdl.org on Sun, Jun 26, 2005 at 04:03:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>   the recent PCI breakage sorted out.

I'm not sure what PCI breakage you're referring to, but a lot of the
Cardbus-centric "breakage" isn't a regression - it's new machines
with weird PCI BIOS setups being incompatible Linux's current PCI
bus handing strategy.

I've been trying to get this fixed for a considerable time, but linux-pci
folk seem to be disinterested.

The assumption that the PCI BIOS will sanely assign the PCI bus numbers
and that Linux does not need to reassign them is looking increasingly
incorrect - most of the Cardbus "why can't the system see my card"
are resolved by passing "pci=assign-busses", which causes the PCI
subsystem to renumber all PCI busses.

So far, no one who has tried this solution has reported any additional
problems that I'm aware of.

Therefore, maybe that should become the default behaviour?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
