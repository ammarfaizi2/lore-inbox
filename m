Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTGVAdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 20:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270770AbTGVAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 20:33:14 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:8917 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270765AbTGVAdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 20:33:12 -0400
Message-ID: <3F1C888B.8040500@rackable.com>
Date: Mon, 21 Jul 2003 17:42:51 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Make menuconfig broken
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc> <3F1C8739.2030707@rackable.com>
In-Reply-To: <3F1C8739.2030707@rackable.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 00:48:12.0717 (UTC) FILETIME=[EDCE55D0:01C34FEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:

> Charles Lepple wrote:
>
>>
>> Note to defconfig maintainers: can these options be enabled by 
>> default on
>> i386 (like they were in 2.4)?
>>
>> Things that you might want to enable:
>>
>> CONFIG_ISA=y
>>
>> CONFIG_SERIO=y
>> CONFIG_SERIO_I8042=y
>> CONFIG_INPUT_AT_KEYBOARD=y
>>
>> CONFIG_VT=y
>> CONFIG_VT_CONSOLE=y
>> CONFIG_HW_CONSOLE=y
>>
> Actual the i386 defconfig does this:
> [root@grendel linux-2.6.0-test1]# grep -e VT -e HW_CONSOLE  -e SERIO 
> -e INPUT_AT_KEYBOARD arch/i386/defconfig
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> [root@grendel linux-2.6.0-test1]#
>
>
>  However a "make oldconfig" on a 2.4 .config doesn't pick this up.  In 
> fact it appears to be impossible to select  CONFIG_VT  
> CONFIG_VT_CONSOLE in make menuconfig.
>

  Try this in 2.6.0-test1:
rm .config
make mrproper
make menuconfig

  There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
character devices in "make menuconfig.

  This works:
rm .config
make mrproper
cp arch/i386/defconfig .config
make menuconfig


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


