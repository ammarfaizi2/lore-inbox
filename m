Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUE1LD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUE1LD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUE1LD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:03:27 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52996 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261184AbUE1LDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:03:25 -0400
Subject: Re: 2.6.7-rc1-mm1: revert
	leave-runtime-suspended-devices-off-at-system-resume.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040527233432.GE7176@slurryseal.ddns.mvista.com>
References: <1085658551.1998.7.camel@teapot.felipe-alfaro.com>
	 <20040527233432.GE7176@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Message-Id: <1085742197.1684.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 28 May 2004 13:03:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 01:34, Todd Poynor wrote:

> > 2.6.7-rc-mm1 includes
> > "leave-runtime-suspended-devices-off-at-system-resume" which causes
> > mayor problems when used on my ACPI laptop. After resuming from S3
> > (STR), both the CardBus and UHCI-HCD bridges won't come up from
> > suspension, rendering them completely unusable: neither my CardBus NIC,
> > nor my USB mouse are recognized or functional.
> 
> Aargh, USB drivers appear to be the only drivers to modify that field, I
> didn't catch that, sorry.  The following patch against 2.6.6 adds a new
> field for "previous state", so that drivers that modify their own
> dev->power.power_state during the suspend callback will be resumed.  Can
> send a patch to fix 2.6.7-rc1-mm1 if desired.

I would like to see the patch against 2.6.7-rc1-mm1.
Thanks!

