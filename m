Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVDCEFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDCEFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDCEFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:05:10 -0500
Received: from ip214-49.coastside.net ([207.213.214.33]:16325 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S261464AbVDCEFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:05:06 -0500
Mime-Version: 1.0
Message-Id: <p06230501be751b6350cc@[192.168.0.3]>
In-Reply-To: <1112429616.24111.7.camel@mindpipe>
References: <88056F38E9E48644A0F562A38C64FB6004629635@scsmsx403.amr.corp.intel.com>
 <1112429616.24111.7.camel@mindpipe>
Date: Sat, 2 Apr 2005 20:04:58 -0800
To: LKML <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: RE: x86 TSC time warp puzzle
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:13 AM -0500 4/2/05, Lee Revell wrote:
>On Fri, 2005-04-01 at 23:05 -0800, Pallipadi, Venkatesh wrote:
>>  It can be SMI happening in the platform. Typically BIOS uses some SMI
>  > polling to handle some devices during early boot. Though 500 
>microseconds > sounds a bit too high.
>
>Nope, that sounds just about right.  Buggy BIOSes that implement ACPI
>via SMM (or so I have been told) can stall the machine for over a
>millisecond, this is why some laptops lose timer ticks at HZ=1000.  The
>issue is well known by Linux audio users, as it causes big problems for
>people who buy laptops for live audio use.

This is a desktop board, and this is well after boot (hours). Also, 
ACPI is disabled in the BIOS.

I suppose I can try to disable SMI via the APIC?
-- 
/Jonathan Lundell.
