Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVJ0BoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVJ0BoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJ0BoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:44:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:64210 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932620AbVJ0BoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:44:13 -0400
Subject: Re: 2.6.14-rc5 (i386) + TSC, how to disable? time drift
From: john stultz <johnstul@us.ibm.com>
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <436029D4.9080601@lazarenko.net>
References: <436029D4.9080601@lazarenko.net>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 18:44:11 -0700
Message-Id: <1130377451.27168.386.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 03:13 +0200, Vladimir Lazarenko wrote:
> Hello,
> 
> To continue on my struggle with Dual-core - another interesting issue 
> popped up: time drift.
> 
> SMP is enabled, TSC is enabled.

It looks like you have ACPI PM and HPET enabled in the kernel, so it
appears your system does not support alternative clocksources. 

You can check to see if a updated BIOS that makes ACPI PM or HPET
available to the OS has been released, or request one from your hardware
vendor.

You might want to try idle=poll as well.

thanks
-john

