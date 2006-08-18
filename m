Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHRGnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHRGnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWHRGnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:43:41 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:16046 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750723AbWHRGnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:43:41 -0400
Date: Thu, 17 Aug 2006 23:43:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Miller <davem@davemloft.net>
Cc: ashok.s.das@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM Please Help
Message-ID: <20060818064338.GA28939@tuatara.stupidest.org>
References: <8032e0b00608172322y6e77b9d9v3f8cd73e8a7b454d@mail.gmail.com> <20060817.233910.78711257.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817.233910.78711257.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 11:39:10PM -0700, David Miller wrote:

> The IRQ for the network device is not being enabled properly.  The
> MOUSE happens to be on the same shared interrupt as the network
> device so when you move it the interrupt handler for the network
> device gets invoked too.
>
> Just my guess...

Some (a lot) of VIA silicon needs a quirk for interrupts to work
properly (ACPI should do the work for us but it's not reliable).

Please apply:

    http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/pci-quirk_via_irq-behaviour-change.patch

and see if that helps.
