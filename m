Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVANB5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVANB5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVANB5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:57:21 -0500
Received: from cml183.neoplus.adsl.tpnet.pl ([83.31.139.183]:13841 "EHLO
	defiant.pm.waw.pl") by vger.kernel.org with ESMTP id S261724AbVANBym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:54:42 -0500
To: Adam Anthony <AAnthony@sbs.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux HDLC Stack - N2 module
References: <4F23E557A0317D45864097982DE907941A38A8@pilotmail.sbscorp.sbs.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 14 Jan 2005 02:53:37 +0100
In-Reply-To: <4F23E557A0317D45864097982DE907941A38A8@pilotmail.sbscorp.sbs.com> (Adam
 Anthony's message of "Thu, 13 Jan 2005 09:02:20 -0700")
Message-ID: <m3vfa0ojxa.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Anthony <AAnthony@sbs.com> writes:

> Krzysztof and Ueimor,
> 	Following the advice prescribed below, I've had a look at existing
> HDLC work in the kernel.  I tried firing up a Riscom/N2 adapter with the
> 2.4.28 N2 module and HDLC support but was faced with a number of problems.
> It seems like the transmit buffers aren't getting emptied after transmit,
> because I can only transmit a few frames before traffic halts.  Transmit
> statistics don't increment either, but I am seeing frames on the remote end.

Looks like IRQ problem. Can you see IRQ handler being called?
I.e. doesn the counter in /proc/interrupts increment?

> 	Has the N2 module been tested with recent kernels?  Is it useable?

It should be, though I haven't used N2 card for a year maybe.
Still, other cards (c101 and pci200syn) share the same low-level
driver core, I know people with c101 (not sure about their kernel
versions) and I personally use pci200syn with latest 2.6 kernels.

There are some issues wrt Frame-Relay code (no PVC list locking,
there is some small possibility of kernel panic etc. while removing
a PVC on live interface - will fix when time permits, problem never
reported).
-- 
Krzysztof Halasa
