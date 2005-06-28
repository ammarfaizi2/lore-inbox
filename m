Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVF1SAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVF1SAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVF1SAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:00:41 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:43789 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262160AbVF1SAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:00:14 -0400
Message-ID: <42C19214.6070708@shadowconnect.com>
Date: Tue, 28 Jun 2005 20:08:20 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com> <20050628162125.GA9239@suse.de>
In-Reply-To: <20050628162125.GA9239@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH wrote:
> On Tue, Jun 28, 2005 at 05:02:41PM +0200, Markus Lidel wrote:
>>I know, but i hopefully also have a good reason to do so... First, the 
>>attributes provided through these functions are for accessing the 
>>firmware... The controller has a little limitation, it could only handle 
>>64 blocks, but sysfs only have 4k...
>>Now there are two options:
>>1) when writing: read a 64k block, merge it with the 4k block and write 
>>it back, when reading: read a 64k block and only return the needed 4k block.
>>2) extend the sysfs attribute to allow 64k blocks
>>IMHO the first is not a very good solution, because for a 64k block it 
>>has to be written 16 times...
>>Of course if someone finds a better solution i would be glad to hear 
>>about it...
> Use the binary file interface of sysfs, which was written exactly for
> this kind of thing. :)

Oh i tried to use the binary interface, but i haven't found a way to 
increase the block size beyond 4k, could you please tell me how i could 
adjust it, or where i could read about it?

Thank you very much!


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
