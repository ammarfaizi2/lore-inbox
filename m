Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbUBQGFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUBQGFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:05:39 -0500
Received: from fmr03.intel.com ([143.183.121.5]:53927 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266046AbUBQGF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:05:29 -0500
Subject: Re: 2.6.2 ACPI problem
From: Len Brown <len.brown@intel.com>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@vision.ee>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8C53@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8C53@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1076997915.2510.15.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2004 01:05:15 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lenar,
Did this start in 2.6.2, or did it happen with previous kernels too? 
Does it also happen in 2.6.3?

On Tue, 2004-02-10 at 09:33, Lenar Lõhmus wrote:
> Hi,
> 
> Having problems here with ACPI on Compaq Evo N610c laptop.
> Everything boots up fine except when loading battery module
> one gets this:
> 
>     ACPI-1120: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40),
> AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C14E] (Node c157bc40),
> AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed [\_SB_.C198._BTP]
> (Node c1577d20), AE_AML_UNINITIALIZED_LOCAL
> ACPI: Battery Slot [C198] (battery present)
> ACPI: Battery Slot [C199] (battery absent)
> 
> Tried with and without RELAXED_AML.
> 
> Now despite this machine seems to work fine until kde's laptop daemon
> does something I'm not aware of which results in
> these lines in dmesg:
> 
> Feb 10 17:52:35 debian kernel:     ACPI-0245: *** Error: Cannot
> release
> Mutex [_GL_], not acquired
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C12C] (Node c157bf80),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C145] (Node c157bcc0),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C14C] (Node c157bc60),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C14C] (Node c1577ee0),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C198._BST] (Node c1577da0),
> AE_AML_MUTEX_NOT_ACQUIRED
> 
> Aftwerwards whole KDE hangs (but that's probably KDE's problem) also
> trying to run 'acpi' on command line stalls and is not interruptible.
> Shutdown stalls do.
> 
> Any solutions or something to try?

Well, to treat the symptom (and isolate the problem) see if things work
better when you disable the battery driver:

CONFIG_ACPI_BATTERY=n

(or simply remove the battery driver under /lib/modules...)

cheers,
-Len




