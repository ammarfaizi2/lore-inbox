Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbSJAUhr>; Tue, 1 Oct 2002 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJAUhr>; Tue, 1 Oct 2002 16:37:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1039 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S262256AbSJAUhq>;
	Tue, 1 Oct 2002 16:37:46 -0400
Message-ID: <3D9A08E1.4040905@namesys.com>
Date: Wed, 02 Oct 2002 00:43:13 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, god@namesys.com
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
References: <20021001195914.GC6318@stingr.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:

>This is the stupidiest testcase I've done but it worth seeing (maybe)
>
>We create 300000 files named from 00000000 to 000493E0 in one
>directory, then delete it in order.
>
>Tests taken on ext3+htree and reiserfs. ext3 w/o htree hadn't
>evaluated because it will take long long time ...
>
>both filesystems was mounted with noatime,nodiratime and ext3 was
>data=writeback to be somewhat fair ...
>
>	       	real 	      	user  		sys
>reiserfs:
>Creating: 	3m13.208s	0m4.412s	2m54.404s
>Deleting:	4m41.250s	0m4.206s	4m17.926s
>
>Ext3:
>Creating:	4m9.331s	0m3.927s	2m21.757s
>Deleting:	9m14.838s	0m3.446s	1m39.508s
>
>htree improved this a much but it still beaten by reiserfs. seems odd
>to me - deleting taking twice time then creating ...
>
>  
>
Can you send us the code so we can try it on reiser4?  We are going to 
release reiser4 sometime this month (don't ask me when), and we'd be 
happy to see you run it when you do.

Hans

