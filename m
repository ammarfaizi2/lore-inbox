Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVHOWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVHOWLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVHOWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:11:17 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:54421 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S965002AbVHOWLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:11:16 -0400
Date: Tue, 16 Aug 2005 00:11:00 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Naveen Gupta <ngupta@google.com>
Cc: wim@iguana.be, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] set enable bit instead of lock bit of Watchdog Timer in Intel 6300 chipset
Message-ID: <20050815221058.GA18633@hardeman.nu>
References: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 02:21:05PM -0700, Naveen Gupta wrote:
>
>This patch sets the WDT_ENABLE bit of the Lock Register to enable the
>watchdog and WDT_LOCK bit only if nowayout is set. The old code always
>sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
>end up locking the watchdog instead of enabling it.

Naveen,

thanks alot for testing the driver further and finding these bugs. I've 
not been able to do so myself as the only computers available to me with 
this watchdog are production-servers meaning that I've only been able to 
test during scheduled downtimes.

Have you tested and verified that the driver works after these patches 
have been applied?

Re,
David
