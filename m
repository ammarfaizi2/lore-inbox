Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIHVkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIHVkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIHVkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:40:00 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:16543 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751189AbWIHVj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:39:56 -0400
Message-ID: <4501E33B.50204@cfl.rr.com>
Date: Fri, 08 Sep 2006 17:40:11 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Thomas Maier <balagi@justmail.de>, linux-kernel@vger.kernel.org,
       "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling
 fix
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com>
In-Reply-To: <20060908210042.GA6877@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2006 21:40:11.0725 (UTC) FILETIME=[5CCB4FD0:01C6D38F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14680.000
X-TM-AS-Result: No--14.922800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Sep 08, 2006 at 07:55:08PM +0200, Thomas Maier wrote:
>> +/sys/block/pktcdvd/<pktdevname>/packet/
>> +    statistic         (r)  Show device statistic. One line with
>> +                           5 values in following order:
>> +                              packets-started
>> +                              packets-end
>> +                              written in kB
>> +                              read gather in kB
>> +                              read in kB
> 
> Please no.  One value per file is the sysfs rule.
> 

Except in cases like this where you want to read the status of the 
device at a given point in time, and you can't do that unless you grab 
all the values at once.


