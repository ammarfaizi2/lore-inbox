Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbTIOUxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTIOUxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:53:24 -0400
Received: from peabody.ximian.com ([141.154.95.10]:41437 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261600AbTIOUxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:53:23 -0400
Message-ID: <3F66249A.3020308@ximian.com>
Date: Mon, 15 Sep 2003 16:44:10 -0400
From: Kevin Breit <mrproper@ximian.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need fixing of a rebooting system
References: <1063496544.3164.2.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>	 <3F6450D7.7020906@ximian.com>	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>	 <1063561687.10874.0.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>	 <3F64FEAF.1070601@ximian.com>	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>	 <1063650478.1516.0.camel@localhost.localdomain> <1063653132.224.32.camel@clubneon.priv.hereintown.net>
In-Reply-To: <1063653132.224.32.camel@clubneon.priv.hereintown.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:

>On Mon, 2003-09-15 at 14:27, Kevin Breit wrote:
>
>  
>
>>I disabled ACPI and that didn't help.  I reenabled it now and I'm
>>looking for other options to disable.  But I don't know where to start. 
>>Any suggestions?
>>    
>>
>
>What CPU are you running on?  It isn't an Opteron is it?  I saw the same
>thing with the NUMA support for the AMD64.
>
>Use "make menuconfig" and have a look at all the options under the first
>few menus.  Make sure your CPU and power management options look right
>for your machine.  When in doubt read the help text for the option, it
>is sometimes very helpful.
>
>  
>
/proc/cpuinfo says:

model name:   Celeron (Coppermine)

So my configuration for the first 5 main menu items that are enabled in 
makeconfig are:

* Prompt for developer and/or incomplete code/drivers
  * Select only drivers expected to compile cleanly
  * Select only drivers that don't need compile-time external firmware

* Support for paging of anonymous memory
   * System V IPC
   * BSD Process Accounting
   * Sysctl support
* Subarchitecture Type (PC-compatible)
* Processor family (Pentium-II/Celeron(pre-Coppermine))
* Preemptible Kernel
* Machine Check Exception
* /dev/cpu/microcode
* /dev/cpu/*/msr
* /dev/cpu/*/cpuid
* BIOS Enhanced Disk Drive calls determine boot disk
* Power Management support
   *Full ACPI Support (minus the ASUS Laptop Extras and Toshiba Laptop 
Extras)

Do you see anything in that list which I should look into ditching first?

Thanks

Kevin Breit

