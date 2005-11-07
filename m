Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVKGClf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVKGClf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVKGClf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:41:35 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:34512 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932291AbVKGCle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 21:41:34 -0500
From: "ext3crypt" <ext3crypt@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: Am I thinking correctly?
Date: Sun, 6 Nov 2005 21:18:00 -0500
Message-ID: <PFEILFFLMPNHAOBNBGPJGEHDCHAA.ext3crypt@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a masters project for PSU.  It requires that I modify the
ext3 and fs code in the kernel proper.

The idea is to encrypt data just prior to it being written to disk.  I've
created a new version of __block_write_full_page (which is called from
writepage) to allocate a new (GFP_NOFS) page, setup the buffer_head list and
copy the data to the new page (and encrypt it too).  When I do this, the
data is not written to disk from the new buffer_head that I submit using
submit_bh().  I've treked through this code and I'm convinced I'm down the
right path.  Am I?  Any assistance would be appreciated.






