Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUEaQqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUEaQqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUEaQqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:46:51 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:17578 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264691AbUEaQqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:46:48 -0400
Message-ID: <40BB61C0.5020902@namesys.com>
Date: Mon, 31 May 2004 09:48:00 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Vladimir Saveliev <vs@namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Alexander Zarochentcev <zam@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>
Subject: I would like to see ReiserFS V3 enter a feature freeze real soon.
References: <20040528122854.GA23491@clipper.ens.fr>	 <1085748363.22636.3102.camel@watt.suse.com>	 <1085750828.1914.385.camel@tribesman.namesys.com> <1085751695.22636.3163.camel@watt.suse.com>
In-Reply-To: <1085751695.22636.3163.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I like and appreciate the data journaling stuff, and I think it 
should go in, real soon now I think we should avoid adding new features 
to V3.  Let the mission critical server folks have a reiserfs version 
that only gets bug fixes added to it, and let V4 be for those who want 
excitement.

Are there any things which Chris and Jeff think should go in besides 
data journaling/ordering and bitmap algorithm changes?

Also, I would like to see some serious benchmarks of the bitmap 
algorithm changes before they go in.  They seem nice in theory, and some 
users liked them for their uses, but that does not make a serious 
scientific study.  Such a study has a high chance of making them even 
better.;-)

zam, I view you as the block allocator maintainer, please review that 
bitmap code from Chris.

Chris and Jeff, can you propose a benchmarking plan for the bitmap code?

Hans


Chris Mason wrote:

>On Fri, 2004-05-28 at 09:27, Vladimir Saveliev wrote:
>
>  
>
>>>The good news is that we tracked this one down recently.  2.6.7-rc1
>>>shouldn't do this anymore.
>>>
>>>      
>>>
>>Just out of curiosity, what was it?
>>    
>>
>
>It was a bug in reiserfs_file_write caused by the data=ordered changes. 
>I was dropping i_sem before changing i_size, and the result was that
>writepage was zeroing out bytes it thought was past the end of the file.
>
>See the recent thread with "1352 NUL bytes at the end of a page?" in the
>subject.  The funny part was that we started getting bug reports for
>this on the suse kernel just a few days before Steven Cole reported it,
>so I was able to overlap some of the bug hunting/testing.
>
>-chris
>
>
>
>
>
>  
>

