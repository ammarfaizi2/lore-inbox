Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUGETHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUGETHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUGETHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:07:55 -0400
Received: from fmr11.intel.com ([192.55.52.31]:44164 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S266173AbUGETHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:07:53 -0400
Subject: Re: problems getting SMP to work with vanilla 2.4.26
From: Len Brown <len.brown@intel.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089054464.15675.56.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 15:07:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-03 at 22:05, Zack Brown wrote:
> Hi folks,
> 
> When booting vanilla 2.4.26 with SMP enabled, I get a lockup before
> the
> boot sequence is completed. The same kernel with SMP disabled boots
> and runs
> just fine. Both CPUs are detected by the system at bootup, before lilo
> takes
> over. Here's the error as I wrote it down from the screen, followed by
> the
> .config file:
> 
> ------------------------------ cut here ------------------------------
> Using local APIC timer interrupts.
> Calibrating APIC timer...
> ..... CPU clock speed is 1004.4785 MHZ
> ..... hostbus clock speed is 133.9304 MHz
> cpu: 0, clocks: 1339304, slice: 446434
> CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> cpu: 1, clocks: 1339304, slice: 446434
> CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> ------------------------------ cut here ------------------------------

complete dmesg from success case would help,
but try booting with "acpi=off", as that will
disable ACPI for CPU enumeration, and if there
is a bug in your ACPI tables, it would avoid it.

-Len


