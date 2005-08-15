Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVHOWS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVHOWS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVHOWS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:18:28 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:37517 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S965010AbVHOWS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:18:27 -0400
Date: Mon, 15 Aug 2005 15:17:44 -0700 (PDT)
From: Naveen Gupta <ngupta@google.com>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
cc: Naveen Gupta <ngupta@google.com>, wim@iguana.be, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] set enable bit instead of lock bit of Watchdog Timer
 in Intel 6300 chipset
In-Reply-To: <20050815221058.GA18633@hardeman.nu>
Message-ID: <Pine.LNX.4.56.0508151514190.28426@krishna.corp.google.com>
References: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
 <20050815221058.GA18633@hardeman.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Yes, I have tested these patches. In fact I found these bugs while trying
to make the driver work on our machines.

-Naveen

On Tue, 16 Aug 2005, David Härdeman wrote:

> On Mon, Aug 15, 2005 at 02:21:05PM -0700, Naveen Gupta wrote:
> >
> >This patch sets the WDT_ENABLE bit of the Lock Register to enable the
> >watchdog and WDT_LOCK bit only if nowayout is set. The old code always
> >sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
> >end up locking the watchdog instead of enabling it.
> 
> Naveen,
> 
> thanks alot for testing the driver further and finding these bugs. I've 
> not been able to do so myself as the only computers available to me with 
> this watchdog are production-servers meaning that I've only been able to 
> test during scheduled downtimes.
> 
> Have you tested and verified that the driver works after these patches 
> have been applied?
> 
> Re,
> David
> 
