Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUHOVgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUHOVgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266915AbUHOVgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:36:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266910AbUHOVgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:36:23 -0400
Message-ID: <411FD744.2090308@pobox.com>
Date: Sun, 15 Aug 2004 17:36:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: new tool:  blktool
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just posted "blktool" on my SF page,
	http://sourceforge.net/projects/gkernel/
and in BitKeeper at
	bk://gkernel.bkbits.net/blktool


blktool aims to be an easier to use, and more generic version of the 
existing utility 'hdparm'.  For example,

	$ hdparm -c1 /dev/hda
		becomes
	$ blktool /dev/hda pio-data 32-bit

	and

	$ hdparm -L0 /dev/hda
		becomes
	$ blktool /dev/hda media unlock

The utility is currently still fairly specific to IDE devices (as hdparm 
is), but that will change in the coming weeks as SCSI, I2O, and possibly 
some bits of hardware RAID control are added.

The audience for this application, like hdparm, is fairly narrow, 
specific to people who tweak their storage devices and _know what they 
are doing_.  Improper use of this tool, like hdparm, can turn your disk 
into a doorstop.

	Jeff



