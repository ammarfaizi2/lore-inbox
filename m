Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUE0NpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUE0NpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUE0NpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:45:18 -0400
Received: from rs1.physik.Uni-Dortmund.DE ([129.217.168.30]:43149 "EHLO
	rs1.physik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264482AbUE0NpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:45:14 -0400
Date: Thu, 27 May 2004 15:45:09 +0200
From: Robert Fendt <fendt@physik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
Message-Id: <20040527154509.37350580.fendt@physik.uni-dortmund.de>
In-Reply-To: <1085102192.12349.508.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	<1084584998.12352.306.camel@dhcppc4>
	<20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
	<1084818282.12349.334.camel@dhcppc4>
	<20040521015314.7001a9e9.fendt@physik.uni-dortmund.de>
	<1085102192.12349.508.camel@dhcppc4>
Organization: Lehrstuhl =?ISO-8859-1?B?Zvxy?= experimentelle Physik I,
 =?ISO-8859-1?B?VW5pdmVyc2l05HQ=?= Dortmund
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2004 21:16:32 -0400
Len Brown <len.brown@intel.com> wrote:

> Please verify that the problem goes away when you exclude the
> acpi/processor module (CONFIG_ACPI_PROCESSOR) from the system.
> 
> With the recent spate of C3 issues, we should make an easier way to
> disable C3 until it is fixed...

Sorry for the delay, but I could not do further tests before now. I have
now at least managed to get 2.6.6 to boot on the box (although it breaks
the synaptics mouse pad driver, but that's a different matter; this too
seems to be ACPI-related, though). The boot problem was the new cpufreq
detection mode producing a seg'fault during boot (and guess what: ACPI
again).

So far I can confirm the following: 1) the problem still exists in 2.6.6
and 2) the problem can be switched on and off be (un)loading the
'processor' module. Test environment is still Debian-unstable, this time
with 2.6.6 vanilla kernel in Debian distro config (a.k.a. pretty bloated
but most things as modules).

I do not expect different results when disabling processor support
during kernel compile. Of course I can try this, if wanted. Any patch
suggestions to try out so far?

Regards,
Robert
