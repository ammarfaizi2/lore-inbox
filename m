Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTGVA1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 20:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTGVA1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 20:27:35 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:32212 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270763AbTGVA1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 20:27:34 -0400
Message-ID: <3F1C8739.2030707@rackable.com>
Date: Mon, 21 Jul 2003 17:37:13 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Lepple <clepple@ghz.cc>
CC: michaelm <admin@www0.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 won't go further than "uncompressing" on a p1/32MB
      pc
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc>
In-Reply-To: <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 00:42:35.0030 (UTC) FILETIME=[24876360:01C34FEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Lepple wrote:

>michaelm said:
>  
>
>>That is on a p1 150MMX 32MB PC, specifically an IBM ThinkPad 560E. It
>>    
>>
>
>I just did a diff between your configuration, and that of my ThinkPad 770
>(233 MHz Pentium MMX).
>
>Note to defconfig maintainers: can these options be enabled by default on
>i386 (like they were in 2.4)?
>
>Things that you might want to enable:
>
>CONFIG_ISA=y
>
>CONFIG_SERIO=y
>CONFIG_SERIO_I8042=y
>CONFIG_INPUT_AT_KEYBOARD=y
>
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
>
Actual the i386 defconfig does this:
[root@grendel linux-2.6.0-test1]# grep -e VT -e HW_CONSOLE  -e SERIO -e 
INPUT_AT_KEYBOARD arch/i386/defconfig
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
[root@grendel linux-2.6.0-test1]#


  However a "make oldconfig" on a 2.4 .config doesn't pick this up.  In 
fact it appears to be impossible to select  CONFIG_VT  CONFIG_VT_CONSOLE 
in make menuconfig.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


