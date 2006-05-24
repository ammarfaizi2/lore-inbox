Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWEXQyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWEXQyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWEXQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:54:49 -0400
Received: from www.osadl.org ([213.239.205.134]:47069 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751003AbWEXQyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:54:49 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>, Yann.LEPROVOST@wavecom.fr,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148488687.24623.67.camel@localhost.localdomain>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
	 <1148475334.24623.45.camel@localhost.localdomain>
	 <1148476383.5239.54.camel@localhost.localdomain>
	 <1148484729.14683.5.camel@localhost.localdomain>
	 <1148485943.24623.54.camel@localhost.localdomain>
	 <1148486614.5239.63.camel@localhost.localdomain>
	 <1148488687.24623.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 18:55:06 +0200
Message-Id: <1148489706.5239.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 12:38 -0400, Steven Rostedt wrote:
> OK I haven't worked on arm much at all. Only had to port one board
> before, and didn't need to get too involved.
> 
> Can't two devices share the same interrupt line? Not talking about a
> cascading interrupt controller, but two actual devices that can trigger
> a single interrupt line.  So, if this is the case, how do you disable a
> particular source without going to the driver itself?

Yeah, the demux code has to go into the device driver to figure that
out, which is not hard to do on SoC devices, as the peripherals are
usually unique for a given SoC family.

PCI and other globally shared devices are completely differnt beasts and
you would need a legion of hackers to fix that up.

	tglx


