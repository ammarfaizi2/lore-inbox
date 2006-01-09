Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWAISCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWAISCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWAISCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:02:00 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:10373 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S964895AbWAISBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:01:54 -0500
Message-ID: <1136829634.43c2a4c2e0997@www.domainfactory-webmail.de>
Date: Mon, 09 Jan 2006 19:00:34 +0100
From: lkml@cl.domainfactory-kunde.de
To: Andi Kleen <ak@muc.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET RTC emulation: add watchdog timer
References: <20060109154350.GA22126@turing.informatik.uni-halle.de> <20060109164140.GA67021@muc.de>
In-Reply-To: <20060109164140.GA67021@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Jan 09, 2006 at 04:43:50PM +0100, Clemens Ladisch wrote:
> > To prevent the emulated RTC timer from stopping when interrupts
> > are disabled for too long, implement the watchdog timer to
> > restart it when needed.
>
> The interrupt handler should just read the time (it likely
> has to do that anyways)

Not in the current implementation.

> and check for that directly.

I want to avoid the read altogether because the round trip to the
south bridge is rather slow (1.5 microseconds with VIA chipsets).


Clemens

