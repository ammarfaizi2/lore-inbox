Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVARCmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVARCmC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVARCmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:42:02 -0500
Received: from fmr18.intel.com ([134.134.136.17]:36531 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261214AbVARCmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:42:00 -0500
Subject: Re: [PATCH] fixup debug warnings during ACPI S3  resume from ram
From: Li Shaohua <shaohua.li@intel.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <200501150124.16589.linux-kernel@borntraeger.net>
References: <200501150124.16589.linux-kernel@borntraeger.net>
Content-Type: text/plain
Message-Id: <1106016061.23148.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 18 Jan 2005 10:41:01 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 08:24, Christian Borntraeger wrote:
> During the wakeup from suspend-to-ram I get several warnings (see below).
> This patch fixes the warnings for me, but I am not an expert in ACPI. Please 
> read the patch and consider to apply it. 
Thanks looking at this issue. We (intel ACPI team) have many discussions
about this issue. Actually this problem isn't so easy. The warning is
when doing resume PCI link device with interrupt disabled. A more
important issue is suspend/resume is doing with all processes frozen,
which will cause many issues such as semaphore, memory mapping, kmalloc.
The real solution is on going. I'll let you know when it's ready.

Thanks,
Shaohua

