Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTERQR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTERQR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:17:27 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2957 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262117AbTERQRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:17:25 -0400
Date: Sun, 18 May 2003 05:42:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 727] New: Consistent crash on kernel startup 
Message-ID: <14490000.1053261731@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Consistent crash on kernel startup
    Kernel Version: 2.5.69-bk12
            Status: NEW
          Severity: high
             Owner: davej@codemonkey.org.uk
         Submitter: mhughes@mhughes.dhs.org


Distribution: red hat 8.0
Hardware Environment:Athlon XP1900 
Software Environment:gcc 3.2
Problem Description:oops on kernel startup - soon after lilo prompt

Steps to reproduce: try to boot 2.5.69-bk12 (.config that worked well with 2.5.67)

I couldn't scroll back through the oops - hope this is enough info. This crashed
3 times in a row, so I should be able to reproduce easily if I can add info. I
copied the oops by hand off the console, so I may have missed something or
mis-copied something - ask if something looks odd ...

Oops looked like:
esi: 0x01 edi: 0xc15cf540 ebp: 0xdff7fee4 esp: 0xdff7fed0
ds: 0x007b es: 0x007b ss: 0x0068

Process swapper(pid:1)

Call Trace:
agp_uio_probe+0x180
sysfs_create_dir+0x7e
pci_device_probe+0x58
bus_match+0x43
driver_attach+0x5d
bus_add_driver+0x9b
driver_register+0x31
pci_register_driver
agp_via_init+0x15

code: 8b 10 85 d2 74 2f b8 00 e0 ff ff 21 e0 ff 40 14 83 3a 02 0f

If I can provide any more info, feel free to let me know ... this one seems
easy to reproduce. If this is a duplicate, apologies ...


