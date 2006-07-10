Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWGJIt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWGJIt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGJIt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:49:27 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:56212 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751365AbWGJIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:49:26 -0400
Subject: RE: 2.6.18-rc1-mm1
From: Arjan van de Ven <arjan@linux.intel.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: greg@kroah.com, linux-acpi@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@redhat.com,
       Reuben Farrelly <reuben-lkml@reub.net>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF9C0@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9C0@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 10:48:49 +0200
Message-Id: <1152521329.4874.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 13:47 -0400, Brown, Len wrote:
> >> 2. Onto some more minor warnings:
> >> 
> >> ACPI: bus type pci registered
> >> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> >> PCI: Not using MMCONFIG.
> >> PCI: Using configuration type 1
> >> ACPI: Interpreter enabled
> >> 
> >> Is there any way to verify that there really is a BIOS bug 
> >there?  If it is, is there anyone within Intel or are there any
> >known contacts 
> >who can push and poke > to get this looked at/fixed?
> >(It's a new Intel board, I'd hope they could get it right..).
> 
> Arjan should probably comment on that one.

I could.. but please next time if you want to CC me use an email address
I actually read ;)

Greg has a patch to relax this check, and Rajesh has a further patch to
relax it more. However, to a large degree we cannot relax it too much
without breaking the reason this check is there: detect a buggy MCFG
table and not crash and burn later on, but rather just not use it.

