Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269254AbUICQZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269254AbUICQZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUICQZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:25:33 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27059 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269254AbUICQZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:25:30 -0400
Message-ID: <41389AF8.2000405@namesys.com>
Date: Fri, 03 Sep 2004 09:25:28 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: flx@msu.ru
CC: bzolnier@milosz.na.pl, Justin Piszcz <jpiszcz@lucidpixels.com>,
       zam@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: A few filesystem benchmarks w/ReiserFS4 vs Other Filesystems
References: <Pine.LNX.4.61.0408271037080.15499@p500> <200408271745.41722.bzolnier@elka.pw.edu.pl> <20040903100812.GA32387@alias>
In-Reply-To: <20040903100812.GA32387@alias>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Lyamin wrote:

>Fri, Aug 27, 2004 at 05:45:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
>  
>
>>Hi,
>>    
>>
>>>Execute rm -rf linux-2.6.8.1 on each file system.
>>># -------------------------------------------------------------------- #
>>>ext2 | 10.26 sec @ 22% cpu
>>>ext3 | 10.02 sec @ 25% cpu
>>>  jfs | 26.67 sec @ 27% cpu
>>>  rs3 | 03.22 sec @ 74% cpu
>>>  rs4 | 25.58 sec @ 50% cpu <- What happened to reiserfs4 here?
>>>  xfs | 12.51 sec @ 47% cpu
>>># -------------------------------------------------------------------- #
>>>Create a 500MB file with dd to each filesystem with 1MB blocks.
>>># -------------------------------------------------------------------- #
>>>ext2 | 15.72 sec @ 26% cpu
>>>ext3 | 17.04 sec @ 31% cpu
>>>  jfs | 29.57 sec @ 25% cpu
>>>  rs3 | 15.21 sec @ 27% cpu
>>>  rs4 | 23.96 sec @ 23% cpu <- What happened to reiserfs4 here?
>>>      
>>>
Do a dd of a 50GB file, I expect a completely different result.  
Basically, this is an artifact of reiser4 choosing to flush the whole 
file once it starts to flush.

>>>  xfs | 19.07 sec @ 29% cpu
>>>      
>>>
>
>Your answers somewhere in HCH's "silent semantics" thread.
>
>Basically reiserfs team aware that they do suck at file DELETES
>and OVERWRITES.  There seem to be a way to rectify this perfomance
>issues in future (dynamic repacker?). Altough i was somewhat surprised
>with this  dd file benchmark... probably Alexander Zarochentsev knows
>the answer.
>  
>

