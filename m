Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDEIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDEIzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDEIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:55:50 -0400
Received: from mail.bencastricum.nl ([213.84.203.196]:8970 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S261626AbVDEIzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:55:13 -0400
Date: Tue, 5 Apr 2005 10:54:09 +0200 (CEST)
From: Ben Castricum <benc@bencastricum.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2 compile error in drivers/usb/class/cdc-acm.c
Message-ID: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: benc@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.12-rc1 compiles and runs perfectly.

gcc version 2.95.3 20010315 (release)

  CC [M]  drivers/usb/class/cdc-acm.o
In file included from drivers/usb/class/cdc-acm.c:63:
include/linux/usb_cdc.h:117: field `bDetailData' has incomplete type
make[3]: *** [drivers/usb/class/cdc-acm.o] Error 1
make[2]: *** [drivers/usb/class] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


I also get several warnings while compiling the kernel:


  CC      fs/quota_v2.o
fs/quota_v2.c: In function `v2_write_dquot':
fs/quota_v2.c:399: warning: unknown conversion type character `z' in
format
fs/quota_v2.c:399: warning: too many arguments for format

  CC [M]  drivers/acpi/processor_idle.o
drivers/acpi/processor_idle.c: In function
`acpi_processor_power_seq_show':
drivers/acpi/processor_idle.c:868: warning: unknown conversion type
character `z' in format
drivers/acpi/processor_idle.c:868: warning: too many arguments for format
drivers/acpi/processor_idle.c:899: warning: unknown conversion type
character `z' in format
drivers/acpi/processor_idle.c:899: warning: too many arguments for format
drivers/acpi/processor_idle.c:906: warning: unknown conversion type
character `z' in format
drivers/acpi/processor_idle.c:906: warning: too many arguments for format

my .config can be found at

http://www.bencastricum.nl/.config

Hope this helps,
Ben
