Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTANX4C>; Tue, 14 Jan 2003 18:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTANX4C>; Tue, 14 Jan 2003 18:56:02 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:25584
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S265351AbTANX4A>; Tue, 14 Jan 2003 18:56:00 -0500
Message-ID: <3E24A5EF.2060903@aslab.com>
Date: Tue, 14 Jan 2003 16:06:07 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec 79xx > 1GB I/O errors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting the following I/O errors while stress testing a 
system with the latest Adaptec 79xx driver (1.3.0BETA2):

Jan 14 09:29:13 asl200 kernel: SCSI disk error : host 0 channel 0 id 0 
lun 0 return code = 8000002
Jan 14 09:29:13 asl200 kernel: Info fld=0x86c552, Deferred sd08:02: 
sense key Hardware Error
Jan 14 09:29:13 asl200 kernel: Additional sense indicates Internal 
target failure
Jan 14 09:29:13 asl200 kernel:  I/O error: dev 08:02, sector 487312

Jan 14 10:36:37 asl200 kernel: (scsi0:A:0:0): Locking max tag count at 64

This is with kernel 2.4.19 + 2.4.19rc5aa1.  I have tested with several 
different Ultra 320 drives, with the same result.  If I remove memory 
from the machine so that it only has 1GB, then everything is solid as a 
rock.  If I plug a zero channel raid controller into the same system 
(dpt_i2o), then I don't get any I/O error regardless of the amount of 
RAM.  Any thoughts?

Mike

