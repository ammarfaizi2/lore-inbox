Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWJHAwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWJHAwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWJHAwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:52:50 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:33160 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751839AbWJHAwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:52:50 -0400
Message-ID: <45284BE0.7030600@comcast.net>
Date: Sat, 07 Oct 2006 20:52:48 -0400
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unable to find root fs with libata only 2.6.18-mm3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont have scsi or ide/ata support compiled into my kernel, only the 
libata drivers, now that they're split out from the scsi tree.  As far 
as I could see from the "help" dialog, this was a valid configuration.   
However, I can't load the root fs using any scsi device name or ide 
device name.  eg, /dev/sda1, /dev/sdb1, /dev/sdc1, /dev/hda1 etc etc.  I 
tried the LABEL=/ option in the boot args, which should work and that 
gave me nothing.   

My question is, do I still need to compile in scsi disk/cdrom/generic 
support into my kernel to get libata devices to work or is there some 
other syntax i'm missing?    Libata detects my drives, but as far as I 
could see, and it flies by too fast to read, no device nodes were 
assigned to them.

If you do need scsi support, why isn't that done automatically when you 
select your libata drivers? or at least a pointer in the "Help" dialog 
to tell you to enable that ?
