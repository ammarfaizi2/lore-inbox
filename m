Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJ3Jz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJ3Jz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:55:29 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:28577 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262280AbTJ3Jz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:55:27 -0500
Message-ID: <3FA0E00E.3060804@namesys.com>
Date: Thu, 30 Oct 2003 12:55:26 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <Pine.LNX.4.58.0310300943430.14300@denise.shiny.it>
In-Reply-To: <Pine.LNX.4.58.0310300943430.14300@denise.shiny.it>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>On Thu, 30 Oct 2003, Hans Reiser wrote:
>
>  
>
>>>We can do this simply by associating UUID's to files, and storing the
>>>the file metadata in a MySQL database which can be searched via
>>>appropriate userspace libraries which we provide.
>>>
>>>      
>>>
>>What a performance nightmare.  Updating a user space database every time
>>a file changes --- let's move to a micro-kernel architecture for all of
>>the kernel the same day.....;-)
>>    
>>
>
>If applications do not cooperate explicitly, there is no other way than
>scanning the files after they have been modified. Sure, it's slow, but
>there is no need to do the work immediately. Take into account the MS's
>goal is to make the system seem fast to the normal (desktop) user. I
>guess that system is aimed to speedup searches in word and text files,
>not in the whole filesystem. And the normal desktop user do write files
>only sometimes, so performance isn't a problem (unless you're copying a
>whole CD of word files into the HD). I think that intercepting
>open,write,close is enough to provide the same functionality in Linux.
>
>
>--
>Giuliano.
>
>
>  
>
I was not very articulate here.  I agree that automatic text indexing 
should be done with a lag in batches for performance reasons, rather 
than in the BeFS style.  I also think that it should not be done for all 
files, that the user should have control over what he runs the indexer 
on, and what indexer he likes to run, and what settings it uses, etc.  
In particular, the user should be free to index by hand.

All that said, the indexes themselves should just be feature enhanced 
directories accessed via the kernel.  Feature enhancements might include 
such things as better space efficiency, ordering plugins, etc.

-- 
Hans


