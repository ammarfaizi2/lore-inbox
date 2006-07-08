Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWGHKZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWGHKZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGHKZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:25:19 -0400
Received: from www.osadl.org ([213.239.205.134]:56740 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932327AbWGHKZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:25:17 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Avi Kivity <avi@argo.co.il>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AF8668.2070306@argo.co.il>
References: <1152352309.3120.15.camel@laptopd505.fenrus.org>
	 <44AF8668.2070306@argo.co.il>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 12:28:06 +0200
Message-Id: <1152354486.24611.316.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 13:18 +0300, Avi Kivity wrote:

> I didn't suggest the compiler could or should do it, just that it would 
> be possible (for the _user_) to write portable ISO C code to access PCI 
> mmio registers, if volatile's implementation serialized access.

And how is this portable on complex multibus architectures, where the
PCI access goes through a couple of transports before hitting the PCI
hardware ?

volatile has no notion of serialization. volatile guarantees that the
compiler does not optimize and cache seemingly static values, i.e. it
disables compiler optimizations.

	tglx


