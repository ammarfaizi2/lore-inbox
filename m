Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTFZDMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTFZDMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:12:15 -0400
Received: from smtp51.safecom.co.nz ([146.171.16.51]:64005 "EHLO
	smtp51.safecom.co.nz") by vger.kernel.org with ESMTP
	id S265373AbTFZDMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:12:08 -0400
Message-ID: <2DE9C01365D7F443AC48EEA6A357FB4F6C79B4@coastapps.westcoastdhb.org.nz>
From: Miles Roper <mroper@westcoastdhb.org.nz>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Thinstation-Developer (E-mail)" 
	<thinstation-developer@lists.sourceforge.net>
Subject: buffer mem
Date: Thu, 26 Jun 2003 15:25:58 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Been searching around on the net for an answer to this and haven't found
much after several hours.

My question is optimising a 2.4.20 version of the kernel for a low memory
machine.  One thing I've been trying to find out is how do you reduce the
amount of buffer mem,

doing a free 

              total         used         free       shared      buffers
  Mem:       321448        35080       286368            0         4892
 Swap:            0            0            0
Total:       321448        35080       286368

always returns a buffer of around 4000, I would like to reduce this to
around 1000, as the machine I'm compiling the kernel for (not the one above)
has 16 meg of memory.  In the 2.2 kernel there was some parameters in
/proc/sys/vm called buffermem, in a lot of the documentation that ships with
2.4.20 talks about this, but after searching on the net it seems like these
were removed in the 2.4 kernel and only applies to 2.2

I've found some documentation on some embedded systems tips which is meant
to reduce kernel memory requirements and have made these changes

Description					VARIABLE		OLD
NEW	File
Number of supported disks		DK_MAX_MAJOR	16	4
include/linux/kernal_stat.h
Number of supported disks		DK_MAX_DISK 	16	4
include/linux/kernal_stat.h
Maximum block device driver number	MAX_BLKDEV		255	40
include/linux/major.h
kmsg message log size			LOG_BUF_MEM		16384	8192
kernel/printk.c
Maxium number of tty consoles		MAX_NR_CONSOLES	63	10
include/linux/tty.h

So is there any other variables controlling the buffer mem, and/or any other
variables that can safely reduce the memory requirements.

Cheers

Miles
