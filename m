Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGEU0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGEU0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUGEU0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:26:02 -0400
Received: from fmr99.intel.com ([192.55.52.32]:11213 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261724AbUGEUZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:25:37 -0400
Subject: Re: System not booting after acpi_power_off()
From: Len Brown <len.brown@intel.com>
To: Joerg Sommrey <jo@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF35A@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF35A@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089059128.15675.77.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 16:25:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 16:36, Joerg Sommrey wrote:
> Hello,
> 
> my box behaves a bit strange after "shutdown -h".  The system performs
> a
> clean shutdown, but afterwards the front-side power button doesn't
> power-on anymore.  After turning off power completely for 5 - 10 sec
> using the power supply's rear-side switch system boots again.  I found
> a
> hint that this might be caused by a power supply that doesn't fully
> conform to ATX 2.01.  Though this might be the real cause of my
> problem,
> I'd like to know if there is a workaround.  Shutting down from an
> older
> Knoppix-CD (kernel 2.4.20 using apm) works fine, i.e. "front-side
> power-on" works.  However, with 2.6 running on a SMP box there seems
> to
> be no way to poweroff via apm.
> 
> Is there a way to let machine_power_off() behave like apm_power_off()
> on
> a SMP box?
> 
> My system:
> kernel: 2.6.7-mm1 (same with other 2.4 and 2.6)
> CPU:    2 x Athlon MP
> board:  Tyan Tiger MPX (S2466)

It is possible that you have a Control Method power button
rather than Fixed Function, and that it is currently disabled
as a wakeup device.  complete dmesg or output from acpidmp
would tell.

-Len


