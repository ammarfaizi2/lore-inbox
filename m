Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUB0JA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUB0JA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:00:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:32711 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261741AbUB0JAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:00:55 -0500
X-Authenticated: #4512188
Message-ID: <403F0743.3060808@gmx.de>
Date: Fri, 27 Feb 2004 10:00:51 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <20040227001115.GA2627@werewolf.able.es>
In-Reply-To: <20040227001115.GA2627@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 02.26, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/
>>
>>- Big knfsd update.  Mainly for nfsv4
>>
>>- DVB udpate
>>
>>- Various fixes
>>
> 
> 
> As somebody also stated, there are problems with sensors:
> 
> werewolf:~# service lm_sensors start
> Loading sensors modules: 
> w83781d-isa-0290: Can't access procfs/sysfs file for writing;
> Run as root?
> Starting sensord:                                               [  OK  ]
> 
> I _was_ root. And initscripts are run as root ?
> 
> Perhaps this is a more generic problem with sysfs :(.

Oh, yes I have noticed the same: "sensors -s" complained about some 
writeing issue. As I son't know what it is good for, I didn't care. 
Backing out bk-i2c.patch, above command works again, and even before 
doing that comand my sensors all worked as they should.

Prakash
