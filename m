Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWHXDe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWHXDe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWHXDe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:34:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55777 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030244AbWHXDe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:34:28 -0400
Message-ID: <44ED1E41.40606@garzik.org>
Date: Wed, 23 Aug 2006 23:34:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Linux: Why software RAID?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Perkel wrote:
> Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0
> striping on the motherboard. Just wondering if hardware raid (SATA2) is
> going to be faster that software raid and why? 


First, it sounds like you are confusing motherboard "RAID" with real 
RAID.  There's a FAQ for this sort of thing:

	http://linux-ata.org/faq-sata-raid.html

In particular, your motherboard's Raid 0 striping (a) is not done in 
hardware, and (b) has nothing to do with SATA2.

But anyway, to help answer the question of hardware vs. software RAID, I 
wrote up a page:

	http://linux.yyz.us/why-software-raid.html

Generally, you want software RAID unless your PCI bus (or more rarely, 
your CPU) is getting saturated.  With RAID-0, there is no duplication of 
data, and so, PCI bus and CPU usage should be about the same for 
hardware and software RAID.

	Jeff


