Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUGMSHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUGMSHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUGMSHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:07:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:46240 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265701AbUGMSH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:07:28 -0400
Date: Tue, 13 Jul 2004 20:07:27 +0200
From: Olaf Hering <olh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Gary_Lerhaupt@Dell.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Message-ID: <20040713180727.GA11583@suse.de>
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40CF0049.2010307@pacbell.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jun 15, David Brownell wrote:

> Gary_Lerhaupt@Dell.com wrote:
> >Stuart Hayes here at Dell has identified this or/and mix-up in the
> >ehci-hcd driver.  Because of this, ehci-hcd is not properly released by
> >BIOSes supporting full 2.0 and port behavior can then become erratic.
> 
> Good patch, it should be merged.  That handoff code actually
> predates general availability of BIOSes handling _any_ EHCI
> controllers, and your patch resolves a problem I'd seen on a
> newish board but hadn't yet had time to track down (beyond
> knowing that broken BIOS handoff was the issue).

David,

there are 2 reports about breakage by this patch. One is on lkml, and
another one is in my bugzilla inbox. How can we fix that one? I assume
that handoff patch is correct.

  <6>NET: Registered protocol family 17
  <3>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
  <3>ehci_hcd 0000:00:1d.7: can't reset
  <3>ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
  <4>ehci_hcd: probe of 0000:00:1d.7 failed with error -95

this is a FSC Amilo D7830 notebook, the guy on lkml has a  Asus P4P800 board.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
