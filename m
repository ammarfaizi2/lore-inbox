Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVAMXS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVAMXS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVAMXSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:18:25 -0500
Received: from loki.cs.umass.edu ([128.119.243.168]:13472 "EHLO
	mail.cs.umass.edu") by vger.kernel.org with ESMTP id S261815AbVAMXQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:16:00 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <106F50BA-65B9-11D9-9300-003065F94C4C@cs.umass.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Armen Babikyan <armenb@cs.umass.edu>
Subject: Hardware sensors problem with 2.4.21 on IBM eServer 335/345
Date: Thu, 13 Jan 2005 18:15:50 -0500
X-Mailer: Apple Mail (2.619)
X-Spam-Net-Tests: NO (loki, relay 24.60.184.135 auth=armenb)
X-Spam-Checked: This message probably not SPAM
X-Spam-Score: -4.901, Required: 5
X-Spam-Tests: BAYES_00
X-Spam-Report-$ThisHost: ---- Start SpamAssassin (v2.6xx-cscf) results
	-4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	                            [score: 0.0000]
X-MIMEDefang-Relay-1852595aaf0946a4530a11f79d6f33e3dfd75698: 24.60.184.135
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to get hardware sensors (i.e. cpu temp, fan speed, and 
voltage sensors) working on an IBM eServer 335 system that is running 
RedHat (Enterprise edition) with kernel 2.4.21 (2.4.21-27 actually).

The driver for the sensors chip on this particular mainboard is found 
using sensors-detect:

Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge

However, the driver failed to load with the following error:

i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-piix4.o version 2.6.5 (20020915)
i2c-piix4.o: Found CSB5 device
dmi_scan.o version 2.6.5 (20020915)
dmi_scan.o: SM BIOS found
i2c-piix4.o: IBM Laptop detected; this module may corrupt
              your serial eeprom! Refusing to load module!
i2c-piix4.o: Module insertion failed.

Obviously this machine is not an IBM Laptop!  It is, in fact, a 
rackmount server.  My question is: is this machine still at risk of 
this EEPROM corruption bug that is present in (what looks like 
exclusively) certain models of IBM Thinkpads?  I can easily comment out 
this logic and recompile, but I really don't want to break my EEPROM!  
Can anyone tell me with reasonable certainty that I won't break my 
machine by forcibly installing this module?

I'd upgrade to a newer version of the linux kernel, but other users of 
the machine have requested the kernel version be kept for support 
reasons.

Any and all insight is greatly appreciated!

Thanks!

   - Armen

