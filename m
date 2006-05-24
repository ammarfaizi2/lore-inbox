Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbWEXNMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWEXNMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWEXNMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:12:47 -0400
Received: from www.osadl.org ([213.239.205.134]:7899 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932737AbWEXNMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:12:47 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yann.LEPROVOST@wavecom.fr, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148475334.24623.45.camel@localhost.localdomain>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
	 <1148475334.24623.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 15:13:03 +0200
Message-Id: <1148476383.5239.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 08:55 -0400, Steven Rostedt wrote:
> Thomas or Ingo,
> 
> Maybe the handling of IRQs needs to handle the case that shared irq can
> have both a NODELAY and a thread.  The irq descriptor could have a
> NODELAY set if any of the actions are NODELAY, but before calling the
> interrupt handler (in interrupt context), check if the action is NODELAY
> or not, and if not, wake up the thread if not done so already.

As I said yesterday. You need a demultiplexer for such cases.

	tglx


