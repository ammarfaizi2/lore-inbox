Return-Path: <linux-kernel-owner+w=401wt.eu-S1161357AbXAHTbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbXAHTbo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbXAHTbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:31:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:8433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161357AbXAHTbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:31:42 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,160,1167638400"; 
   d="scan'208"; a="34094042:sNHT19219068"
Message-ID: <45A29C09.8050901@linux.intel.com>
Date: Mon, 08 Jan 2007 22:31:21 +0300
From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de> <459D5079.70605@linux.intel.com> <459EE89F.1010505@rrz.uni-koeln.de> <459F6366.5080609@linux.intel.com> <45A13DF8.2030207@rrz.uni-koeln.de>
In-Reply-To: <45A13DF8.2030207@rrz.uni-koeln.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berthold Cogel wrote:
> Alexey Starikovskiy schrieb:
>
>   
>>> Hello Alex,
>>>
>>> I still get the same diffs. Except the yenta part of course. And the
>>> system is still rebooting.
>>>
>>> Berthold
>>>   
>>>       
>> Good, yenta is cleared :) Could you replace /drivers/acpi/ec.c with the
>> version from 2.6.19.x and try again?
>>
>> Regards,
>>    Alex.
>>     
>
> Hi Alex!
>
> I did what you suggested. First I replaced ec.c in linux-2.6.20-rc2 (see
> attached dmesg-2.6.20-rc2.ec.txt) with the version from linux-2.6.19.1
> and in a second step I also replaced i2c_ec.c and i2c_ec.h
> (dmesg-2.6.20-rc2.i2c_ec.txt).
>
> In both cases the only result I can see is the absence of the 'ACPI: EC:
> evaluating' messages in the logs. The system is still rebooting instead
> of doing a clean shutdown.
>
> Regards,
> Berthold
>
>   
Excellent, ACPI printing of queries is cleared as well :)
There are two ways to debug further... git-bisect and unloading modules 
before shutdown (or not loading them)...
While second is easier and could isolate a module, the first could be 
way more productive:
http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

Thanks in advance,
    Alex.
 
