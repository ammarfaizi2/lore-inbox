Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUA1Vny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUA1Vny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:43:54 -0500
Received: from fmr03.intel.com ([143.183.121.5]:26536 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266194AbUA1Vnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:43:51 -0500
Subject: Re: acpi - forcing only button event & powerdown on?
From: Len Brown <len.brown@intel.com>
To: Nick Bartos <spam99@2thebatcave.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AE587@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AE587@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075326225.2496.16.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Jan 2004 16:43:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to force acpi on, but only for the couple of things I
> need
> (disabling the rest if it is a good idea), so I don't get into trouble
> later?

yes, build with...
CONFIG_ACPI=y
CONFIG_ACPI_BUTTON=y
everything else =n
make oldconfig (which will turn on CONFIG_ACPI_BOOT, INTERPRETER) and
build...

For your system on the acpi=ht blacklist, you'll need acpi=force to
over-ride it.  Note that as ACPI has gotten better, some of the systems
on the blacklist have come off.  acpi-devel@lists.sourceforge.net would
be a good place to bring up that issue for a particular platform.

cheers,
-Len


