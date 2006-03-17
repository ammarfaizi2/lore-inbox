Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWCQRZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWCQRZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCQRZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:25:51 -0500
Received: from mail.dvmed.net ([216.237.124.58]:62927 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751120AbWCQRZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:25:50 -0500
Message-ID: <441AF118.7000902@garzik.org>
Date: Fri, 17 Mar 2006 12:25:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.org.uk>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk>
In-Reply-To: <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:
> On 17 Mar 2006, at 16:00, Jeff Garzik wrote:
>> Jörn Engel wrote:
>>>>> The one still painfully missing is a
>>>>> fixed-endianness disk format.

>> Fixed endian isn't necessarily a requirement.  Detectable endian  is.  
>> As long as (a) the filesystem mkfs notes the endian-ness and  (b) the 
>> kernel filesystem code properly handles both types of  endian, life is 
>> fine.
>>
> That's what is currently done.  There are two filesystem formats, big  
> endian (donated by Squashfs magic of 'sqsh') and little endian  (denoted 
> by Squashfs magic of 'hsqs').  The kernel code detects the  filesystem 
> endianness and swaps if necessary.

Well, then, I don't see a need to change anything.  As I said, 
[consistent and] detectable endian is the real requirement.  For 
SquashFS's users, I would think they would prefer the current situation 
(selectable endian) to fixed endian, because many SquashFS users need to 
squeeze every ounce of performance out of severely resource-constrained 
devices.

I have two routers, ADM5120-based Edimax and LinkSys WRT54G v5, both of 
which have a mere 2MB of flash, and both use SquashFS to maximize that 
space.  And both are el cheapo, slow embedded processors that run far 
slower than 300Mhz.  I look askance at anyone who wants to make an 
arbitrary filesystem design decision imposing tons of bytesex upon these 
lowly devices.

	Jeff


