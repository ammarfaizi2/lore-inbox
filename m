Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUBLSRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUBLSRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:17:13 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:22534 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S266520AbUBLSRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:17:12 -0500
Date: Thu, 12 Feb 2004 12:17:12 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
To: Ross Dickson <ross@datscreative.com.au>
cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
In-Reply-To: <200402120122.06362.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
References: <200402120122.06362.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Ross Dickson wrote:

> Greetings,
>
> Approaching from this perspective the following patch implements a new idle
> thread. One which does not go into C1 disconnect (hlt) if less than 1.6% of the
> apic timer interval is left to execute. When you think about it, why do we
> disconnect if we are about to reconnect?  It also has a small timing delay
> to help with back to back disconnect cycles ( SMI might put us into one? ).
> The result should be a slightly faster system (then with my apic ack delay
> patch) when busy but still with disconnect functioning to save power and lower
> heat with typical loads.

Is there a measurable performance loss over not having the patch at all?
Some nforce2 systems work just fine.  Is there a way to distinguish
between systems that need it and those that don't?

(if anyone's running a betting pool, my money's on nforce2+cpu with half
frequency multiplier ;)
