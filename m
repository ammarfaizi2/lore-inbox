Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbXAPH3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXAPH3P (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 02:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXAPH3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 02:29:15 -0500
Received: from mail.isohunt.com ([69.64.61.20]:55614 "EHLO mail.isohunt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbXAPH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 02:29:14 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 02:29:14 EST
X-Spam-Check-By: mail.isohunt.com
Message-ID: <45AC7CB2.1010202@isohunt.com>
Date: Tue, 16 Jan 2007 00:20:18 -0700
From: Allen Parker <parker@isohunt.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: 82571EB gigabit on e1000 in 2.6.20-rc5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PCI-E pro/1000 MT Quad Port adapter, which works quite well 
under 2.6.19.2 but fails to see link under 2.6.20-rc5. Earlier today I 
reported this to e1000-devel@lists.sf.net, but thought I should get the 
word out in case someone else is testing this kernel on this nic chipset.

Due to changes between 2.6.19.2 and 2.6.20, Intel driver 7.3.20 will not 
compile for 2.6.20, nor will the 2.6.19.2 in-tree driver.

Error output:
   CC [M]  drivers/net/e1000/e1000_main.o
drivers/net/e1000/e1000_main.c:1132:45: error: macro "INIT_WORK" passed 
3 arguments, but takes just 2
drivers/net/e1000/e1000_main.c: In function 'e1000_probe':
drivers/net/e1000/e1000_main.c:1131: error: 'INIT_WORK' undeclared 
(first use in this function)
drivers/net/e1000/e1000_main.c:1131: error: (Each undeclared identifier 
is reported only once
drivers/net/e1000/e1000_main.c:1131: error: for each function it appears 
in.)
make[3]: *** [drivers/net/e1000/e1000_main.o] Error 1

lspci -nn output (quad port):
09:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:10a4] (rev 06)
09:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:10a4] (rev 06)
0a:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:10a4] (rev 06)
0a:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:10a4] (rev 06)
lspci -nn output (dual port):
07:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:105e] (rev 06)
07:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
Ethernet Controller [8086:105e] (rev 06)

 From what I've been able to gather, other Intel Pro/1000 chipsets work 
fine in 2.6.20-rc5. If the e1000 guys need any assistance testing, I'll 
be more than happy to volunteer myself as a guinea pig for patches.

Allen Parker
