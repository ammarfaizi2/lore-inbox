Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUBWWyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUBWWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:54:49 -0500
Received: from mail.convergence.de ([212.84.236.4]:23682 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262067AbUBWWw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:52:27 -0500
Message-ID: <403A841E.9090700@convergence.de>
Date: Mon, 23 Feb 2004 23:52:14 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Hunold <hunold@linuxtv.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
References: <10775702831806@convergence.de>	<10775702843054@convergence.de> <20040223140943.7e58eb5c.akpm@osdl.org>
In-Reply-To: <20040223140943.7e58eb5c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 02/23/04 23:09, Andrew Morton wrote:
>> 	// read it!
>>-	lseek(fd, tda10045h_fwinfo[fwinfo_idx].fw_offset, 0);
>>+        lseek(fd, fw_offset, 0);
>> 	if (read(fd, firmware, fw_size) != fw_size) {

> was there some plan to convert DVB over to using the firmware loader?

Yes. But as I wrote in the mail to Christoph, we currently don't have a 
chance to use some in-kernel structure (pci device, i2c bus) that 
automatically exports the firmware loading magic through sysfs.

Because of this, we would have to write our own sysfs backend for the 
dvb i2c subsystem, in order to get proper firmware loading support.

As I already mentioned in another mail, we want to go back to the kernel 
i2c subsystem.

Currently, the stuff is running quite stable and is "in use".

Changing the i2c subsystem would require changes in all frontend drivers 
+ plus in the dvb drivers exporting the i2c facilities.

Is such a big change acceptable for 2.6 if it fixes these horrible hacks 
or is this 2.7 stuff?

CU
Michael.
