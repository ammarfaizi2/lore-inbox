Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUEUXTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUEUXTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbUEUXSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:18:04 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:20576 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265125AbUEUXKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:10:43 -0400
Message-ID: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
Date: Thu, 20 May 2004 18:05:10 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Exporting PCI ROMs via syfs
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GregKH has suggested that a good interface for accessing the contents of PCI
ROMs from user space would be to make them available from sysfs. What would be a
good way to structure the code for doing this? Should this be part of the pci
driver, and how would this interface into class_simple to make the attribute
appear?

Some problems:
Radeon cards need a work around sometimes to enable their ROM. But this can be
run once when the driver loads.
There is one card that can't access the ROM and function at the same time, I
believe Alan Cox know which one it is.

Would it be possible for this to be an automatic function of class_simple with
an API for setting a pre-enable callback? The callback would only be used for
cards with bugs like the radeon and Alan's card.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
