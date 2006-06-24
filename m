Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWFXQFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWFXQFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWFXQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:05:10 -0400
Received: from www.osadl.org ([213.239.205.134]:48792 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750851AbWFXQFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:05:09 -0400
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jeff Dike <jdike@addtoit.com>
Cc: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060624152235.GB3627@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <20060622213443.GA22303@thunk.org>
	 <20060623024222.GA8316@ccure.user-mode-linux.org>
	 <20060623210714.GA16661@thunk.org>
	 <20060623214623.GA7319@ccure.user-mode-linux.org>
	 <20060624140001.GA7752@thunk.org>
	 <20060624152235.GB3627@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 18:06:50 +0200
Message-Id: <1151165210.25491.352.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 11:22 -0400, Jeff Dike wrote:
> On Sat, Jun 24, 2006 at 10:00:01AM -0400, Theodore Tso wrote:
> > Looks like UML just crashed (tm), without any explanation.  Kconfig
> > attached.  Suggestions on how to debug this would be appreciated.
> 
> I'm working on this - the genirq stuff in -mm broke UML.  Add stderr=1
> to the command line to see the actual crash.  2.6.17 is fine, except
> you need a klibc patch for O= builds.

Jeff, its the following patch:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/broken-out/genirq-allow-usage-of-no_irq_chip.patch

It was a brown paperbag thinko. Back it out or use -mm2

	tglx


