Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUBZXmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUBZXjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:39:13 -0500
Received: from imap.gmx.net ([213.165.64.20]:29345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261234AbUBZXf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:35:56 -0500
X-Authenticated: #4512188
Message-ID: <403E82D8.3030209@gmx.de>
Date: Fri, 27 Feb 2004 00:35:52 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4, sensors broken
References: <20040225185536.57b56716.akpm@osdl.org>
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this release made my sensors broken. With mm3 it worked nicely.

This is what sensors-detect gives me:

Driver `adm1021' (should be inserted):
   Detects correctly:
   * Bus `SMBus nForce2 adapter at 5100' (Algorithm unavailable)
     Busdriver `i2c-nforce2', I2C address 0x4e
     Chip `National Semiconductor LM84' (confidence: 5)

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus nForce2 adapter at 5100' (Algorithm unavailable)
     Busdriver `i2c-nforce2', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus nForce2 adapter at 5100' (Algorithm unavailable)
     Busdriver `i2c-nforce2', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (may not be inserted):
   Misdetects:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

Of course most of the drivers are not in the kernel, but w83781d worked 
for me with mm3 and now it does not. gkrellm2 still is able to read out 
voltages and fan speeds but no temperatures anymore.

Typing "sensors" just gives me:
w83627hf-isa-0290
Adapter: ISA adapter
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get IN6 data!
ERROR: Can't get IN7 data!
ERROR: Can't get IN8 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get VID data!
alarms:
beep_enable:
           Sound alarm disabled


:-(

Prakash
