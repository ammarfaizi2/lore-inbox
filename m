Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTCFNJY>; Thu, 6 Mar 2003 08:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268093AbTCFNJY>; Thu, 6 Mar 2003 08:09:24 -0500
Received: from [202.54.64.7] ([202.54.64.7]:41745 "EHLO hclnpd.hclt.co.in")
	by vger.kernel.org with ESMTP id <S268091AbTCFNJX>;
	Thu, 6 Mar 2003 08:09:23 -0500
Message-ID: <3E674B7C.E442D16@netlab.hcltech.com>
Date: Thu, 06 Mar 2003 18:52:05 +0530
From: Arun Prasad <arun@netlab.hcltech.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 CRC32 undefined
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
    To install the Fault-Injection tool (fith-mini-13), did the
following steps

* The below are the seps given in the tool README

        1. Apply patch kprobes-2.5.50-bk2.patch
           Apply patch fi-2.5.51-bk1.patch

        2. cd fith_utility
           make
           make install
    So copied kernel 2.5.51 and applied both the patches specified
above.

* Compiled the kernel with the below  in .config file
    CONFIG_MODULES=y
    CONFIG_CRC32=y
    CONFIG_PCNET32=m

* Booted the kernel with the new kernel (2.5.51), but eth0 is not up..
The ethernet driver is not loaded..
    (pcnet32 is the ethernet device of the machine.... it works fine
witht he default 2.4 kernel)

* Did the insmod for the driver
    bash$ insmod ./pcnet32.o
    pcnet32: Unknown symbol crc32_le
    Error inserting "pcnet32.o": -1 Unknown symbol in module

* Checked linux-2.5.51/lib/crc32.c  and found the lines
    EXPORT_SYMBOL(crc32_le);
    EXPORT_SYMBOL(crc32_be)

* There is no /proc/ksyms in the kernel and "ksyms" command doesnt seems
to work....

Can anyone help me out in this....

Thanks
-arun

