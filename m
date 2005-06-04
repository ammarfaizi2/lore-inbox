Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFDEs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFDEs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 00:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFDEs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 00:48:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:8364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261237AbVFDEsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 00:48:23 -0400
Date: Fri, 3 Jun 2005 21:50:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
In-Reply-To: <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
 <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
 <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
 <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
 <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Andreas Koch wrote:
> 
> Actually, I tried that already.  But I didn't get any usable info from
> the oops and GDB (`list *pci_setup_bridge+0x1a2' shows an include file,
> not a line in the function) .  I'll make another attempt tomorrow when
> I am more awake :-)

Usually the easiest way to match up things is to just do

	x/10i pci_setup_bridge+0x1a2

and match it up with "make drivers/pci/setup-bus.s". 

		Linus
