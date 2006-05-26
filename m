Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWEZTZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWEZTZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWEZTZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:25:11 -0400
Received: from rtr.ca ([64.26.128.89]:20146 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751310AbWEZTZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:25:09 -0400
Message-ID: <44775614.5000401@rtr.ca>
Date: Fri, 26 May 2006 15:25:08 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide-owner@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails: libata
 issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly (RAM or disk)
with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 2.6.17-*
I've attempted on this machine).

On resume from RAM, after a 30-second-ish timeout, the screen comes on
but the hard disk is NOT accessible.  "dmesg" in an already-open window
shows this (typed in from handwritten notes):

sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, /dev/sda, sector nnnnnnn

(the nnnnnnn was actually a real number, different on each message).

Is there a fix already floating around for this?

Cheers
