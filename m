Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUCCWwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCCWwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:52:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:18374 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261205AbUCCWwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:52:10 -0500
Subject: Re: Resume only part of device tree?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078344202.3203.22.camel@calvin.wpcb.org.au>
References: <1078344202.3203.22.camel@calvin.wpcb.org.au>
Content-Type: text/plain
Message-Id: <1078353622.15320.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 09:40:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 07:03, Nigel Cunningham wrote:
> Hi all.
> 
> Is there any existing code in the device model that supports resuming a
> part of the device tree? For Suspend2, I'm wanting to resume storage
> devices (and their parents) part way through resuming, and other drivers
> later.

What is your exact goal ? Not resuming all devices when writing the
state to the swap partition ?

You really need to resume it all at this point. However, the optimisation
that can be done is for some drivers to not put the HW to sleep on a
swsusp transition, only freeze the state. I did something like that in
IDE though that doesn't always work well due our "state" paremeter passed
down to drivers not beeing consistent.

Ben.


