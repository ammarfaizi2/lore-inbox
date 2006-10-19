Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161377AbWJSKtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377AbWJSKtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWJSKtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:49:36 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:21380 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1161377AbWJSKtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:49:35 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002707U4537582f@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <alan@redhat.com>, <jesse.barnes@intel.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 19:49:26 +0900
References: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> 
    <20061019.013732.30184567.davem@davemloft.net> 
    <20061019092256.GC5980@devserv.devel.redhat.com> 
    <20061019.022541.85409562.davem@davemloft.net>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X4537582F00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml160610191949195WL]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
>From: Alan Cox <alan@redhat.com>
>Date: Thu, 19 Oct 2006 05:22:56 -0400
>
>> On Thu, Oct 19, 2006 at 01:37:32AM -0700, David Miller wrote:
>> > defined to do this kind of thing, for example with the
>> > pcibios_bus_to_resource() interface, used by routines such as
>> > drivers/pci/quirks.c:quirk_io_region().
>> 
>> pci_iomap() ?
>
>Yep, but that interface needs a BAR.
>
>The "0xc0000" usage here for the VGA rom stuff, and some of the quirk
>examples, want something a little bit different.
>
>I suppose we could create something that cooked up a fake PCI
>device and a BAR, but that is a bit too much for what we're
>trying to do here I'm afraid.

The "0xc0000" is a physical address. The BAR (PCI base address) is also
a physcail address. There are no difference.
