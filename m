Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbTLRLrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbTLRLrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:47:00 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:28108 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S265114AbTLRLq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:46:58 -0500
From: Tom Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: SCSI regression: sym53c8xxx_2 (2.6test11 vs. 2.6final)
Date: Thu, 18 Dec 2003 12:46:47 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312181246.47374.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all: I'm not subscribed to the list so please cc me on replies.

I wanted to report a problem concerning 2.6.0 final with my Tekram DC390U2W 
SCSI controller using the sym53c8xx_2 driver. The same machine was running 
without problems with 2.6test11 and the exactly same .config file.

Booting 2.6.0 final results in the following messages:

[...]
sym0: <895> rev 0x1 at pci 0000:02:0a.0 irq 22
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0: sym-2.1.18b
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT oberation timed-out.
sym0:0:0: DEVICE RESET operation started.
sym0:0:0: DEVICE RESET operation timed-out.
sym0:0:0: BUS RESET operation started.
sym0:0:0: BUS RESET operation timed-out.
sym0:0:0: HOST RESET operation started.
sym0: SCSI BUS has been reset.

After the last line the machine is totally frozen and has to be reset. I'm 
really wondering what is causing this since there were not many changes in 
drivers/scsi from test11 to final.
Any idea what might be going wrong? test11 still boots and works like a charm 
so I don't think that the hardware died over night.

If you need any further information about the specific setup please drop me a 
line.

cat /proc/pci    http://www.wnk.at/tmp/pci.txt
.config    http://www.wnk.at/tmp/config_2.6.txt


Thanks,
-- 
Tom Winkler
e-mail: tom@qwws.net

