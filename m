Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWALSLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWALSLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWALSLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:11:41 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:43738 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S932236AbWALSLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:11:40 -0500
From: Ulrich Mueller <ulm@kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17350.39878.474574.712791@a1i15.kph.uni-mainz.de>
Date: Thu, 12 Jan 2006 19:11:18 +0100
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org>
	<20060107210413.GL9402@redhat.com>
	<43C03214.5080201@ens-lyon.org>
	<43C55148.4010706@ens-lyon.org>
	<20060111202957.GA3688@redhat.com>
	<u3bjtogq0@a1i15.kph.uni-mainz.de>
	<20060112171137.GA19827@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Jan 2006, Dave Jones wrote:

>> $ lspci -s 00:02.0 -v
>> 00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
>> Subsystem: Hewlett-Packard Company nx6110/nc6120
>> Flags: bus master, fast devsel, latency 0, IRQ 16
>> Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
>> I/O ports at 7000 [size=8]
>> Memory at c0000000 (32-bit, prefetchable) [size=256M]
>> Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
>> Capabilities: [d0] Power Management version 2

> Another one that advertises no AGP capabilities.
> In this situation you shouldn't *need* agpgart.  If it's PCI[E],
> radeon will use pcigart.

Problem is that i915 depends on DRM && AGP && AGP_INTEL.
And at the end of i{810,830,915}_dma.c there is the comment:
"All Intel graphics chipsets are treated as AGP, even if they are
really PCI-e."
