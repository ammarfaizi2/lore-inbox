Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWGSOFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWGSOFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGSOFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:05:43 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:64526 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S964841AbWGSOFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:05:43 -0400
Subject: Re: skge error; hangs w/ hardware memory hole
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Jul 2006 15:05:41 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C270464C9FA@uk-email.terastack.bluearc.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: skge error; hangs w/ hardware memory hole
Thread-Index: AcarPGtJbcysCoDkRlm+/TvyTertag==
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm still waiting for a positive test result. Ideally from multiple
people 
> because it's a pretty radical step to blacklist all VIA chipsets like
this
> (and it's s still possible that only some BIOS are broken, not all VIA
boards)
> In fact I've been trying to get confirmation from VIA on this, but
they
> never answered my queries.

With iommu=force, my A8V deluxe system crashes during boot.

With iommu=soft swiotlb=force, the skge driver still has problems:

skge 0000:00:0a.0: PCI error cmd=0x157 status=0x22b0
skge unable to clear error (so ignoring them).

Also seen:

skge 0000:00:0a.0: PCI error cmd=0x117 status=0x22b0

The sk98lin driver prints out loads of garbage too fast for me to read
and I can't stop it either (scroll lock doesn't stop it). It's saying
something like "unexpected IRQ status error" - there's also a number
printed which looks like 0x264.

FWIW the e100 driver works fine without either of these options

-- 
Andy, BlueArc Engineering
