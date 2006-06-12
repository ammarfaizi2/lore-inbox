Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWFLV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWFLV2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFLV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:28:04 -0400
Received: from mail.mazunetworks.com ([4.19.249.111]:5032 "EHLO
	mail.mazunetworks.com") by vger.kernel.org with ESMTP
	id S932349AbWFLV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:28:01 -0400
Message-ID: <448DDC7F.4030308@mazunetworks.com>
Date: Mon, 12 Jun 2006 17:28:31 -0400
From: Jeff Gold <jgold@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial Console and Slow SCSI Disk Access?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it make sense that enabling a serial console would reduce the 
bandwidth of a SCSI disk by more than a factor of ten?  This seems crazy 
to me but there's no arguing with empirical facts.  I have an IBM x345 
system on which I installed an unmodified 2.6.16.20 kernel built with 
gcc-4.0.2-8.fc4 (the kernel configuration file I used can be found at 
http://augart.com/jgold/kconfig).  With the control kernel command line 
I get about 70 MB/sec with hdparm -t but when I add "console=ttyS0,9600 
console=tty0" I get about 1.6 MB/sec instead.

Here are the complete kernel command lines from grub.conf (the second 
one doesn't actually include a backslash in grub.conf -- that's just to 
avoid email wrapping):

   ro root=/dev/sda3 pci=biosirq loglevel=7

   ro root=/dev/sda3 pci=biosirq console=ttyS0,9600n8 console=tty0 \
     loglevel=7

I have not been able to connect this behavior to any known kernel bugs 
using Google or mailing list archives.  What might I be doing wrong?

                                          Jeff
