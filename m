Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTIPPDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTIPPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:03:32 -0400
Received: from mail-10.iinet.net.au ([203.59.3.42]:42185 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261931AbTIPPDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:03:31 -0400
Message-ID: <3F672602.8050003@ii.net>
Date: Tue, 16 Sep 2003 23:02:26 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de> <3F672396.10906@techsource.com>
In-Reply-To: <3F672396.10906@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
>>> 276:    /* OK, it's not open. Create cache info for it */
>>> START -->
>>> 277:    mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
>>> 278:    if (!mtdblks)
>>> END -->
>>> 279:        return -ENOMEM;
> 
> 
>>
>> Invalid.  This is quite an obvious false positive, at least if your
>> algorithm checks for possible value ranges.
> 
> 
> Wait... one is "mtdblk", and the other is "mtdblks".  One has an extra 
> 's' on it.  Unless there is some kind of aliasing going on, they would 
> appear to be different variables.  Naturally, I didn't check the 
> original code, so I could be full of it.  :)
> 
This has been resolved, see Jorn's other mail.

