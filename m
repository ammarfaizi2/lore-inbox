Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRBMWYj>; Tue, 13 Feb 2001 17:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRBMWY3>; Tue, 13 Feb 2001 17:24:29 -0500
Received: from garlic.amaranth.net ([216.235.243.195]:6415 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S131228AbRBMWYL>; Tue, 13 Feb 2001 17:24:11 -0500
Message-ID: <3A89B3FD.62313E6C@egenera.com>
Date: Tue, 13 Feb 2001 17:23:57 -0500
From: Phil Auld <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Stale super_blocks in 2.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	It appears that the umount path in the 2.2 series kernels
does not do anything to invalidate the buffers associated with the
unmounted device. We then rely on disk change detection on a 
subsequent mount to prevent us from seeing the old super_block.

Since deja was gobbled by google it's hard to do a good search of 
this list. Can anyone take the time to help me understand the reason
for this choice? This seems to me to be backwards. When a device is 
unmounted there should be no cached information.

Thanks for the help,


Phil


-- 
------------------------------------------------------
Philip R. Auld, Ph.D.                  technical staff
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
