Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbULBIDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbULBIDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbULBIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:03:15 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:54671 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261288AbULBIDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:03:07 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101837994.2640.67.camel@laptop.fenrus.org>
	<20041130102105.21750596.akpm@osdl.org>
	<1101839110.2640.69.camel@laptop.fenrus.org>
	<20041130184852.GI2714@holomorphy.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 02 Dec 2004 03:03:05 -0500
In-Reply-To: <20041130184852.GI2714@holomorphy.com>
Message-ID: <yq0acsx5dqe.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin <wli@holomorphy.com> writes:

William> On Tue, 2004-11-30 at 10:21 -0800, Andrew Morton wrote:
>>> For pages which have a physical address <4G.  I assume this was
>>> motivated by the lack of an IOMMU on ia32e?

William> On Tue, Nov 30, 2004 at 07:25:10PM +0100, Arjan van de Ven
William> wrote:
>> but there's the swiommu for those... so that can't be it
>> realistically....  Is there code using the zone GFP mask yet ??

William> ZONE_NORMAL and ZONE_DMA are both too overloaded to handle
William> the 4GB boundary. And it makes a lot of sense on more machine
William> types than x86-64 (e.g. ia64, ia32 and others with 32-bit PCI
William> but no zone representing it).

Hardware that doesn't require the broken 24 bit ISA zone already uses
ZONE_DMA for all 32 bit memory - ie. ia64 does this. It works even on
the broken-beyond-repair Intel boxes without an IOMMU.

Cheers,
Jes
