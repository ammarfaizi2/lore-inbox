Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVKQScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVKQScI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKQScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:32:08 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:28800 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932455AbVKQScH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:32:07 -0500
Message-ID: <437CC67C.4060109@soleranetworks.com>
Date: Thu, 17 Nov 2005 11:05:48 -0700
From: jmerkey <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Swap Bug Massive EXT3 Corruption on FC4 with 2.6.14 update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When instaling FC4 on a system which already has FC2 previously 
installed on a second hard drive, the install program becomes
confused and assigns the swap partition to the FC2 system when 
installing FC4.  The kernel then IGNORES the size extents set
for the swap partition (in this case FC2 was set to 1024, FC4 was set to 
2048) and allows the cross mounted swap to grow into
the next partition, totally corrupting the root drive (/) by allowing 
the swap segment to grow into the root drive and overwrite
it.

To reproduce, install FC2 on an /dev/hda device with defaults, then 
install FC4 on a /dev/hdb device, build the 2.6.14 update for
FC4 and watch your data disappear.

Jeff
