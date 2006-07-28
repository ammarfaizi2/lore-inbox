Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752047AbWG1RHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbWG1RHz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbWG1RHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:07:55 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47995 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1752047AbWG1RHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:07:54 -0400
Date: Fri, 28 Jul 2006 11:06:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <Pine.LNX.4.61.0607281902560.4972@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: ravibt@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44CA4400.5020005@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
 <44C79E56.2040603@shaw.ca> <Pine.LNX.4.61.0607281902560.4972@yvahk01.tjqt.qr>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Essentially I don't think there is much you can do about this on this board.
>> The memory space starting at around 3.2GB is being used by the memory-mapped IO
>> regions for the PCI and PCI Express devices and motherboard resources and
>> therefore "covers up" the RAM in that part of the address space. The solution
>> to this is for the system to remap the affected memory above the 4GB mark,
>> which is possible with Athlon 64/Opteron CPUs and on some of the Intel server
>> chipsets. However, I don't think any Intel desktop chipsets support this for
>> some unfathomable reason.
> 
> Maybe PAE can help?

No.. it's not a matter of being unable to reach the address space, but 
the memory used by the IO regions is essentially overridden and 
unavailable to the kernel. PAE is not applicable on x86-64 anyway..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


