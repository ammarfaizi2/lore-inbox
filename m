Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUGGMnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUGGMnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUGGMnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:43:14 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:38153 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S265097AbUGGMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:43:11 -0400
Message-ID: <40EBF07B.8040003@hist.no>
Date: Wed, 07 Jul 2004 14:45:47 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
References: <200407011215.59723.bjorn.helgaas@hp.com> <20040701115339.A4265@unix-os.sc.intel.com> <40EBED33.3050707@roma1.infn.it>
In-Reply-To: <40EBED33.3050707@roma1.infn.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Rossetti wrote:

> Rajesh Shah wrote:
>
>> What type of usage model did you have in mind to have the
>>
>> device write to memory instead of using MSI for interrupts?
>>  
>>
> for instance for a fast wake-up trick. the driver loops on a memory 
> location until the MSI write access changes the memory content...

Won't that put a bad load on the bus?  Someone else might need it:
* Another cpu in a smp system
* Any device doing bus-master transfers, even in a UP system

That polling loop had better be guaranteed to be _very_ short.

Helge Hafting
