Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSGWQfc>; Tue, 23 Jul 2002 12:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSGWQfc>; Tue, 23 Jul 2002 12:35:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55538 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318122AbSGWQfb>; Tue, 23 Jul 2002 12:35:31 -0400
Subject: Re: [PATCH] reduce code in generic spinlock.h
From: Robert Love <rml@mvista.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Adam G Litke <aglitke@us.ibm.com>
In-Reply-To: <3D3D8414.1040201@us.ibm.com>
References: <3D3D8414.1040201@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 09:38:39 -0700
Message-Id: <1027442320.3581.100.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 09:28, Dave Hansen wrote:

> The last time lockmeter was ported to 2.5, it was getting a little
> messy.  There were separate declarations for spin_*lock() for each
> combination of lockmeter and preemption, which made four, plus the
> no-smp definition.  While lockmeter's mess isn't the kernel's fault, 
> we noticed some some simplifications which could be made to the 
> generic spinlock code.  This patch uses a single definition for each 
> of the macros, eliminating some redundant code.

I have no problems with this (assuming it is right and it looks so on
first glance).

It will not apply to Linus's current tree, however, because of the IRQ
rewrite that is now applied.  If you pull his BK tree and diff against
that, you should be OK... most notably, the preemption code has moved to
preempt.h.

	Robert Love

