Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTKXHA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 02:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTKXHA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 02:00:27 -0500
Received: from holomorphy.com ([199.26.172.102]:31160 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263593AbTKXHAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 02:00:23 -0500
Date: Sun, 23 Nov 2003 23:00:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Len Brown <len.brown@intel.com>
Cc: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Message-ID: <20031124070016.GX22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Len Brown <len.brown@intel.com>, Eduard Bloch <edi@gmx.de>,
	linux-kernel@vger.kernel.org, davej@redhat.com
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com> <20031123204532.GA6093@zombie.inka.de> <1069654747.2812.689.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069654747.2812.689.camel@dhcppc4>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-23 at 15:45, Eduard Bloch wrote:
>> #include <hallo.h>
>> * Brown, Len [Sun, Nov 23 2003, 03:16:11PM]:
>> > > weird 1+2xHT mode.

On Mon, Nov 24, 2003 at 01:19:07AM -0500, Len Brown wrote:
> Please try CONFIG_NR_CPUS=8, or apply the patch below to 2.4.23.
> smp_boot_cpus() incorrectly assumes that Local APIC ID's are handed out
> 0,1,2...
> But they're handed out 0,1,6,7 on your system.  #6 happens to be your
> boot CPU, smp_boot_cpus() brings up #0 and #1, and never asks to boot #7
> -- thus 3 logical processors.  If #0 happened to be your boot processor,
> you'd get only 2 logical processors.

A similar (but more elaborate) fix is in 2.6.


-- wli
