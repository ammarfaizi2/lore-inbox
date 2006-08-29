Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWH2HAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWH2HAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWH2HAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:00:10 -0400
Received: from main.gmane.org ([80.91.229.2]:37056 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932113AbWH2HAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:00:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Escombe <lists@dresco.co.uk>
Subject: Lenovo T60 - unable to resume from disk with =?utf-8?b?Q09ORklHX0hJR0hNRU02NEc=?=
Date: Tue, 29 Aug 2006 06:53:49 +0000 (UTC)
Message-ID: <loom.20060829T084849-443@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.68.23.174 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8.0.6) Gecko/20060808 Fedora/1.5.0.6-2.fc5 Firefox/1.5.0.6 pango-text)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using a Lenovo T60 laptop - suspend to disk has always failed for me on resume.

The resume image is read from disk, and then the laptop immediately reboots.
This behavior has been verified up to 2.6.18-rc4, and can be replicated with a
minimal init=/bin/bash boot. printk's scattered through the resume code are
getting into the "for (zone_pfn = 0; zone_pfn < zone->spanned_pages;
++zone_pfn)" loop in snapshot.c / copy_data_pages() before the reboot.

Through trial and error, I've found that this problem only occurs with
CONFIG_HIGHMEM64G (the default in a Fedora installation). On a couple of
occasions I've seen a hang or an oops instead of a reboot. Apologies for the
poor quality, but an image of the oops screen can be found at
http://www.dresco.co.uk/debug/resume_from_disk.jpg

Any pointers to progressing this further would be welcome...

Regards,
Jon.

(Please CC me on replies as I'm not currently subscribed to the list).


