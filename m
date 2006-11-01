Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752368AbWKAUxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbWKAUxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbWKAUxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:53:23 -0500
Received: from www.osadl.org ([213.239.205.134]:13483 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1752367AbWKAUxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:53:22 -0500
Subject: Re: 2.6.19-rc4-mm1: noidlehz problems
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061101152201.GA13634@srcf.ucam.org>
References: <20061101122319.GA13056@elf.ucw.cz>
	 <1162386177.23744.17.camel@laptopd505.fenrus.org>
	 <20061101152201.GA13634@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:55:01 +0100
Message-Id: <1162414502.15900.261.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:22 +0000, Matthew Garrett wrote:
> On Wed, Nov 01, 2006 at 02:02:57PM +0100, Arjan van de Ven wrote:
> 
> > In some (hardware) C-states, the local apic timer stops (as does the
> > TSC), while in others it keeps running. If you change from AC to
> > battery, the bios can change the meaning of a software C-state from one
> > where local apic timer keeps going to one where it stops. This obviously
> > upsets the hrtimers/tickless code since that uses local apic timer for
> > event generation....
> 
> Is there any hope of working around this? I'd have expected that the 
> most useful case for the tickless code was also the case where we want 
> to be using C3/C4...

Can you try the following patches please ?

http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick1.patch

This addresses the C34/C4 issue

	tglx

	

