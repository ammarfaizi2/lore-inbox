Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSJXRcs>; Thu, 24 Oct 2002 13:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbSJXRcs>; Thu, 24 Oct 2002 13:32:48 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.157]:137 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S265564AbSJXRcq>; Thu, 24 Oct 2002 13:32:46 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Thu, 24 Oct 2002 10:39:52 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: jung-ik.lee@intel.com, greg@kroah.com
Subject: Re: PCI Hotplug Drivers for 2.5
Cc: tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Message-Id: <20021025023856.CAVTC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We need this driver as it's the only solution for DIG64 compliant IPF
> platforms.

No, not for all DIG64 compliant IPF platforms.  NEC TX7 is also
a DIG64 compliant IPF platform but doesn't need your driver.

DIG64(2.1) only states that:

 Firmware Support for PCI Hot-Plug
                               : Recommended if PCI Hot-Plug is
                                 implemented
 ACPI Support for PCI Hot-Plug : Recommended for platforms that
                                 implement PCI Hot-Plug without SHPC
 Using PCI Hot-Plug Specifications
                               : Recommended if PCI Hot-Plug is
                                 implemented

The spec also states that any PCI Hot-Plug controller must
follow one of PCI Hot-Plug spec 1.1, SHPC 1.0 or CompactPCI Hot Swap
spec.  It also strongly recommends SHPC 1.0, which is not covered
by J.I.'s driver yet.

But anyway Itanium2 platform using intel's hot-plug controller
will be shipping soon and J.I.'s driver has much better functionality
than acpiphp.  This would be a decent reason for having the
driver in the mainline.

And this also motivates us to clean up the duplicated code if
it were in mainline:)

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

