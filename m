Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264349AbUE0Nfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUE0Nfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUE0Nfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:35:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264349AbUE0NfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:35:19 -0400
Date: Thu, 27 May 2004 09:34:52 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, mingo@elte.hu
Subject: Re: Cleanups for APIC
In-Reply-To: <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0405270931040.28319@devserv.devel.redhat.com>
References: <20040525124937.GA13347@elf.ucw.cz>
 <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
 <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 May 2004, Maciej W. Rozycki wrote:

> > (wrt. io_apic_sync(): i added it in 2.1.104 together with some other
> > changes - i dont this it's necessary anymore - the local APICs had
> > writearound erratas, but i dont remember this ever being necessary for
> > IO-APICs. I'll address this in another patch.)
> 
> Hmm, isn't that needed to make sure the iomem writeback is completed
> before exiting the caller?

the only thing that could happen is a POST delay in the PCI chipset - but
is that really an issue? Plus we only do the io_apic_sync() for the
masking, not the unmasking - so if it's needed then we dont do it
consistently.

	Ingo
