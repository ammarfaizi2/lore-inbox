Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTEaPpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTEaPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:45:39 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:64645 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264357AbTEaPpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:45:36 -0400
Message-Id: <200305311558.h4VFwpKc024058@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: must-fix, version 6
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Date: Sat, 31 May 2003 17:26:12 +0200
References: <20030530235008$3775@gated-at.bofh.it> <20030531095009$09a0@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Fri, May 30, 2003 at 04:37:20PM -0700, Andrew Morton wrote:

>> o Minor interface changes are pending in cio/ when the z990 machines are
>>   out.

This should be at least PRI2, as it will change the user-visible interface,
e.g. the bus_id format for CCW devices. 

>>   There are some more things being worked on that are either post-2.6.0 or
>>   are likely to remain outside of the official kernel (i.e.  not for your
>>  list):
>> 
>>   PRI3

The 'not for your list' actually referred to the items below...

>> o Jan Glauber is working on a fix for the timer issues related to running
>>  on virtualized CPUs (wall-clock vs.  cpu time).
>> 
>>   PRI1

Keep this as PRI3. It would be really nice to have, but I don't expect
it to be stable before 2.6.0. The current code is the same as in 2.4.

>> o the qeth driver will become GPL soon
>> 
>>   PRI3
>> 
>> o a block device driver for ramdisks shared among virtual machines
>> 
>>   PRI3

Ok. We're only waiting for the OK from our lawyers before these 
can be submitted. The qeth driver is ugly, but is the one for
the most common hardware, so it would be nice to have it included
eventually.

>> 
>> o driver for crypto hardware
>> 
>>   PRI2
>> 
>> o 'claw' network device driver
>> 
>>   PRI3
>>
>> o new zfcp fibre channel driver
>> 
>>   PRI3

These three drivers are not fully ported to 2.5 as they are less
important and we have no plan of submitting them for either 2.4
or 2.[567]. The code is also too ugly to be accepted anyway, so you
can drop them from the list. Vendors can pick up the source
from out developerworks site, as always...

> Is there a 2.5 patch of this somewhere?
No. An official release of the zfcp driver should be available at 
the end of this year for linux-2.6. If you want to look at the
code, Heiko Carstens <heiko.carstens@de.ibm.com> can probably
send you a snapshot of his current working version.

        Arnd <><
