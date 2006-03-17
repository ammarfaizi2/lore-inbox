Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWCQQA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWCQQA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCQQA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:00:56 -0500
Received: from mail.dvmed.net ([216.237.124.58]:13517 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751207AbWCQQAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:00:55 -0500
Message-ID: <441ADD28.3090303@garzik.org>
Date: Fri, 17 Mar 2006 11:00:40 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Phillip Lougher <phillip@lougher.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de>
In-Reply-To: <20060317124310.GB28927@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Fri, 17 March 2006 11:16:48 +0000, Phillip Lougher wrote:
> 
>>>The one still painfully missing is a
>>>fixed-endianness disk format.
>>
>>We had that argument last year.
> 
> 
> Yes, I remember.  What I don't remember is your opinion on the matter.
> Did we reach some sort of conclusion?

Fixed endian isn't necessarily a requirement.  Detectable endian is.  As 
long as (a) the filesystem mkfs notes the endian-ness and (b) the kernel 
filesystem code properly handles both types of endian, life is fine.

For SquashFS, though, I would think that fixed endian would be easy. 
Since it is byte-packed, just handle endian as you unpack.

	Jeff



