Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVEBNYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEBNYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEBNYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 09:24:05 -0400
Received: from alpha.polcom.net ([217.79.151.115]:53647 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261232AbVEBNYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 09:24:00 -0400
Date: Mon, 2 May 2005 15:23:57 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: How to flush data to disk reliably?
Message-ID: <Pine.LNX.4.62.0505021503470.11701@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing an app that has log files. These log files must be reliably 
and permanently flushed to disk on some points. These log files can be:
a. normal files on some (local) filesytem,
b. some block device (disk/partition).

I am asking how to flush the data from these logs to disk. I know of 
several methods:
1. open with O_SYNC,
2. sync(2),
3. fsync,
4. fdatasync,
5. msync (if they are mmaped).

Which of these are best and most reliable for (a/b) and for (IDE/SCSI)? 
What are differences between them? Maybe some other method? Are there any 
other precautions that I should be aware of? What about write caches? Are 
write barriers implemented (on IDE and SATA/SCSI) or should I turn caches 
off?

I am using Linux 2.6. (But I will be glad to hear about differences 
between 2.4 and 2.6 in this aspect if there are any.)


Thanks in advance,

Grzegorz Kulewski
