Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTG2FcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271266AbTG2FcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:32:10 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:15233 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271264AbTG2FcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:32:07 -0400
Subject: Re: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728193633.1b2bc9d8.akpm@osdl.org>
References: <1059428584.6146.9.camel@localhost>
	 <20030728144704.49c433bc.akpm@osdl.org>
	 <1059430015.6146.15.camel@localhost>
	 <20030728150245.42f57f89.akpm@osdl.org>
	 <1059444271.4786.25.camel@localhost>
	 <20030728193633.1b2bc9d8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059456725.4781.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 00:32:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 21:36, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> > OK, mucho more info (no wonder root=/dev/hde5 no worky):
> >         VP_IDE: (ide_setup_pci_device:) Could not enable device
> OK, looks like breakage at the PCI level: pci_enable_device_bars() is
> failing; something below pcibios_enable_device().
> 
> What was the most recent kernel which works?

Looks like vanilla -test2 passes muster. Boots, etc.

Trying to find pci related snippets in -test2-mm1 patch... io_apic_* in
io_}apic.c & mpparse.c, some acpi stuff, drivers/pci/probe.c but that
looks like nothing... 

I give up... Yet again... My technical depth seems easily tested in this
arena.
