Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWFVIfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWFVIfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWFVIfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:35:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932454AbWFVIf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:35:29 -0400
Date: Thu, 22 Jun 2006 09:35:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [patch 1/2] genirq: allow usage of no_irq_chip
Message-ID: <20060622083516.GB25212@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	mingo@elte.hu
References: <20060610085428.366868000@cruncher.tec.linutronix.de> <20060610085435.487020000@cruncher.tec.linutronix.de> <20060621161236.e868284d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621161236.e868284d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 04:12:36PM -0700, Andrew Morton wrote:
> On Sat, 10 Jun 2006 10:15:11 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > Some dumb interrupt hardware has no way to ack/mask.... Instead of creating a
> > seperate chip structure we allow to reuse the already existing no_irq_chip
> 
> This is the patch which causes powerpc to crash.  In a quite ugly manner:
> early oops, falls into xmon, keeps oopsing from within xmon.  No serial
> port, too early for netconsole.
> 
> I'll drop it.

Note that dropping it makes the genirq stuff buggy on ARM, so this
needs to be resolved before it can go anywhere near Linus' tree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
