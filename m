Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWGCXLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWGCXLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWGCXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:11:07 -0400
Received: from igw1.zrnko.cz ([81.31.45.160]:49613 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751032AbWGCXLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:11:06 -0400
Date: Tue, 4 Jul 2006 01:11:21 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.6.17-git14 and PCI suspend/resume
Message-ID: <20060703231121.GB2752@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in this kernel I'm seeing these messages after S3 resume:
kernel: PM: Writing back config space on device 0000:01:01.1 at offset f (was 4020205, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset e (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset d (was dc, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset c (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset b (was 19671043, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset a (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 9 (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 8 (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 7 (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 6 (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 5 (was 0, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 4 (was fe8fd800, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 3 (was 804000, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 2 (was c001008, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 1 (was 2100006, writing ffffffff)
kernel: PM: Writing back config space on device 0000:01:01.1 at offset 0 (was 5521180, writing ffffffff)

Which actually mess up PCI config space (and sdhci driver is unable to set up
MMC device correctly). Do you have any idea what to try?

These messages appear for devices that are not handled by any loaded module.

-- 
Luká¹ Hejtmánek
