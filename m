Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUJXQQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUJXQQy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbUJXQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:15:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:18055 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261523AbUJXQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:14:12 -0400
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       "mobil@wodkahexe.de" <mobil@wodkahexe.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0410241615350.14448@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	 <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
	 <16750.23132.41441.649851@alkaid.it.uu.se>
	 <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
	 <16751.54873.668167.981073@alkaid.it.uu.se>
	 <Pine.LNX.4.58L.0410241615350.14448@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098630663.24236.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 16:11:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-24 at 16:44, Maciej W. Rozycki wrote:
> > I agree with Alan that accusing the BIOS of being buggy is unwarranted.
> 
>  I disagree.  If the firmware performs any actions on hardware without
> asking the OS for permission, it *must* be prepared for it to be in any
> possible state and handle it correctly, including any transitional states
> (as it does respect spinlocks).  Otherwise it's buggy.

Show me a PC standards document that says this - there are none.

>  Alan, referring to your statement: it's like stating we must only use the
> text mode of the display adapter, because that's the state it's left in by
> the firmware and it may not expect any other state.

If you switch video mode without using the BIOS then the BIOS video
calls are not guaranteed to work. Its the same thing.


> +		if (enable_local_apic <= 0) {
> +			apic_printk(APIC_VERBOSE,
> +				    "Local APIC disabled by BIOS -- "
> +				    "you can enable it with \"lapic\"\n");
> +			return -1;

Looks good to me in this form.

