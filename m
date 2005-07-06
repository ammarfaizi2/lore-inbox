Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVGGC2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVGGC2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVGFT7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:02 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:48399 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S262305AbVGFQZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:25:08 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12.1 gives panic with ata_piix (irq 11: nobody cared!)
In-Reply-To: <Pine.LNX.4.62.0506301406280.8723@hammer.psislidell.com>
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13-rc1 (i686))
Message-Id: <20050706162501.8C8C713C53@rhn.tartu-labor>
Date: Wed,  6 Jul 2005 19:25:01 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RK> irq 11: nobody cared!
[...]
RK> handlers:
RK> [<c02552e0>] (usb_hcd_irq+0x0/0x60)
RK> [<c02552e0>] (usb_hcd_irq+0x0/0x60)
RK> [<c02552e0>] (usb_hcd_irq+0x0/0x60)
RK> [<f8956230>] (ata_interrupt+0x0/0x100 [libata])
RK> Disabling IRQ #11

This seems very similar to the following irq disabling reports:
http://seclists.org/lists/linux-kernel/2005/Jun/0526.html
http://www.spinics.net/lists/kernel/msg377160.html
http://www.usenetlinux.com/archive/index.php/t-437740.html

So far, only uhci hcd seems to be a common denominator.

In this case, disabling uhci does not cure it, which is strange.

-- 
Meelis Roos
