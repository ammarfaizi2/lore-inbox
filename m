Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKIQVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKIQVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUKIQVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:21:44 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:5760
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261571AbUKIQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:21:43 -0500
Date: Tue, 9 Nov 2004 08:21:42 -0800
From: Phil Oester <kernel@linuxace.com>
To: Len Brown <len.brown@intel.com>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ganesh.venkatesan@intel.com, John Ronciak <john.ronciak@intel.com>
Subject: Re: Spurious interrupts when SCI shared with e100
Message-ID: <20041109162142.GA12926@linuxace.com>
References: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de> <1099978966.6092.36.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099978966.6092.36.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:42:46AM -0500, Len Brown wrote:
> On Mon, 2004-11-08 at 05:59, Udo A. Steinberg wrote:
> > My laptop has IRQ9 configured as ACPI SCI. When IRQ9 is shared between
> > ACPI and e100 an IRQ9 storm occurs when e100 is enabled, as can be
> > seen in the dmesg output below.
> 
> Is this new with 2.6.10-rc1, or has it always been broken in an
> ACPI-enabled kernel with acpi sharing an irq with e100?
> 
> I suspect this may be a bug in the e100 -- it may have enabled
> interrupts before it has registered a handler.

I saw similar behaviour in 2.6.8.1 on a non-ACPI enabled kernel with
a dual-port e100.  The nic simply would not work, spewing this error in
syslog:

NETDEV WATCHDOG: eth1: transmit timed out

If I booted with an ACPI enabled kernel, the box worked again.  IRQ
sharing was involved, though can't recall which IRQ eth1 tried to use.
This was on a brand new Dell Optiplex.

Phil
