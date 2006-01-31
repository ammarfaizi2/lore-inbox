Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWAaAIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWAaAIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWAaAIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:08:05 -0500
Received: from mail.gmx.net ([213.165.64.21]:20448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965046AbWAaAIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:08:04 -0500
X-Authenticated: #13409387
Message-ID: <43DEA922.3030602@gmx.net>
Date: Tue, 31 Jan 2006 01:02:42 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy edac
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <200601301424.16884.dsp@llnl.gov> <43DEA4CA.8070700@gmx.net> <200601301552.09955.dsp@llnl.gov>
In-Reply-To: <200601301552.09955.dsp@llnl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:

>On Monday 30 January 2006 15:44, Gunther Mayer wrote:
>  
>
>>>For each individual type of error that is specific to a particular
>>>low-level chipset driver (e752x, amd76x, etc.) there could be an entry
>>>in the appropriate part of the sysfs hierarchy under the given chipset
>>>driver.  This entry could have several settings that the user may choose
>>>      
>>>
>>>from such as { ignore, syslog, panic }.  For the implementation, there
>>    
>>
>>>could be a generic piece of code in the core EDAC module that a chipset
>>>driver calls into.  The generic code would do the dirty work of creating
>>>the sysfs entries (and destroying them when the chipset module is
>>>unloading).  How does this sound?
>>>      
>>>
>>Over-Engineered.
>>    
>>
>
>Do you have an alternate suggestion?
>  
>
Just printk() the exact driver specific low-level error, even if non-fatal.

Single non-fatal errors just show your system recovers correctly.

Multiple (e.g. noisy) non-fatal are either an indication of a serious 
problem
  (e.g. after how many corrected ECC errors on the same address in which
    time interval will you replace your dimm? How many S-ATA CRC-errors
     will indicate marginal bad cabling? )
or it shows the problem needs to be root analyzed. But don't disable the
messages as this will only hide the real problem.

Concerning Non-Fatal PCI Express errors, the error cause registers need
to be printed in case of error, too (see Intel Chipset Specifications)

-
Gunther


