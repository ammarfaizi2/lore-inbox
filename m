Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVDHQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVDHQYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVDHQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:24:47 -0400
Received: from [195.23.16.24] ([195.23.16.24]:48303 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262867AbVDHQYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:24:44 -0400
Message-ID: <4256B04A.8070909@grupopie.com>
Date: Fri, 08 Apr 2005 17:24:42 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
References: <4252BC37.8030306@grupopie.com> <20050407214747.GD4325@stusta.de> <42567B3E.8010403@grupopie.com> <20050408130008.GA6653@stusta.de>
In-Reply-To: <20050408130008.GA6653@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>[...]
>>>On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
>>
>>Hi Adrian,
> 
> Hi Paolo,

Paulo, please :)

Paolo is Spanish (or Italian), whereas Paulo is a Portuguese name.

>>[...]
>>I think most will agree that the second piece of code is more "readable".
> 
> In this case yes (but it could still use the normal kcalloc).

Yes, but the cleanup is already just barely justifiable. 75% (or more) 
of the calls will use just one parameter. Adding a stupid "1" to all of 
those will make the cleanup even less worth while.

>[...]
> Joerg's list of recursions should be valid independent of the kernel 
> version. Fixing any real stack problems [1] that might be in this list 
> is a valuable task.
> 
> And "make checkstack" in a kernel compiled with unit-at-a-time lists 
> several possible problems at the top.

Ok, I've read Jörn's mail also and I think I can help out. It seems 
however that there are more people working on this. Will it be better to 
coordinate so we don't duplicate efforts or is the "everyone looks at 
everything" approach better, so that its harder to miss something?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
