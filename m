Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265478AbUFCDN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUFCDN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUFCDN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:13:56 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:62367
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S265478AbUFCDNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:13:54 -0400
Message-Id: <200406030303.i5333nof009223@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: Brian Gerst <bgerst@didntduck.org>
cc: root@chaos.analogic.com, reg@dwf.com, linux-kernel@vger.kernel.org,
       reg@orion.dwf.com, linux@horizon.com, reg@orion.dwf.com
From: clemens@dwf.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Wed, 02 Jun 2004 21:11:25 EDT." <40BE7ABD.1050609@quark.didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Jun 2004 21:03:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrong.  Ever since the Pentium Pro, x86 processors have had 36-bit 
*physical* addressing.  This is why PAE-mode paging was introduced.  A 
sane BIOS would configure the memory controller to remap some of the 
memory above 4G physical to allow for memory mapped devices.  It sounds 
like this board's BIOS isn't doing that, or at least not reporting it in 
the e820 map.

---

Hummm.

Let me restate the fact that I dont understand how PC hardware works, but
I can understand how the area for PCI devices has to come out of the
KERNEL address space, but why does it have to be subtracted from the USER
address space too?


-- 
                                        Reg.Clemens
                                        reg@dwf.com






