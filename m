Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTKFSqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTKFSqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:46:55 -0500
Received: from imap.gmx.net ([213.165.64.20]:29100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263244AbTKFSqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:46:53 -0500
X-Authenticated: #4512188
Message-ID: <3FAA978E.6060401@gmx.de>
Date: Thu, 06 Nov 2003 19:48:46 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Matthew Reppert <repp0017@tc.umn.edu>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031106130030.GC1145@suse.de>	 <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de>	 <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de>	 <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de>	 <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de>	 <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de>	 <3FAA5B3A.4090800@gmx.de> <1068140559.359.5.camel@minerva>
In-Reply-To: <1068140559.359.5.camel@minerva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Reppert wrote:

> On Thu, 2003-11-06 at 08:31, Prakash K. Cheemplavam wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
>>>
>>>
>>>>#
>>>># SCSI device support
>>>>#
>>>>CONFIG_SCSI=y
>>>
>>>
>>>Need I say more?
>>
>>But then it is a bug: In menuconfig nothing is activated or please tell 
>>me how through the menu it is possible to set this to "no".
> 
> 
> You have CONFIG_USB_STORAGE=y in your config; USB storage does a
> "select SCSI", which means that if USB storage is active, it forces
> CONFIG_SCSI=y. So, if you turn off USB storage, you can turn off SCSI.
> Making USB storage a module won't help; select seems to always select
> Y.
> 
> Matt

Oh, ok, thanx for clarification. That explains, why scsi subsystem is 
lobed before usbfs. :-) Nevertheless, as said, the as scheduler causes 
the problems.

Prakash


