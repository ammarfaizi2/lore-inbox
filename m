Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUH0Sjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUH0Sjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUH0Sjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:39:33 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:17573 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266917AbUH0SjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:39:05 -0400
Message-ID: <412F7FB8.4010609@blue-labs.org>
Date: Fri, 27 Aug 2004 14:38:48 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Will Dyson <will_dyson@pobox.com>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <412E10A2.1020801@pobox.com> <412EEC07.30707@namesys.com> <412F7B6D.6010305@pobox.com>
In-Reply-To: <412F7B6D.6010305@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------000901000907070902030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901000907070902030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Will Dyson wrote:

> Hans Reiser wrote:
>
>> Will Dyson wrote:
>>
>>>
>>> In the original BeOS, they solved the problem by having the 
>>> filesystem driver itself take a text query string and parse it, 
>>> returning a list of inodes that match. The whole business of parsing 
>>> a query string in the kernel (let alone in the filesystem driver) 
>>> has always seemed ugly to me. 
>>
>>
>> Why?
>
>
> Hmm. Trying to explain aesthetic judgments is always fun, but I'll try.
>
> String parsing bloats the kernel with code that will be called rarely, 
> and doing it inside the filesystem module makes for duplicate code if 
> more than one filesystem does it. But a good common parser routine (or 
> a kernel api that takes a pre-compiled parse tree) would reduce the 
> bad taste.


Like say.. printk() ?  :)

> The real objection I have is that it puts the kernel in the position 
> of doing more work than it has to for the system to operate correctly 
> and efficiently. The user wants to know what files match a certain set 
> of criteria. The filesystem provides special features which can 
> greatly accelerate some searches. Does it make more sense to move the 
> functionality of /usr/bin/find into the kernel, or to export the index 
> information so that an enhanced version of find can make use of it?


I think it depends largely on where you see file systems going 5, 10, 20 
years from now.  Are they going to be decadent designs or will they be 
flush with meta data and other tidbits?  Where does the heuristic line 
sit when it becomes better to put such a function into the kernel v.s. 
user land?

> I don't think having find in the kernel would be worth the cost or 
> complexity.


Probably not.  But as I view it, file systems are slowly evolving into 
relational objects and the margin between what are files and directories 
versus content within said objects is shrinking.  More and more, people 
are using a relational database to store content that once resided in 
singular files.

Sure, it makes for a much fatter *FS system, but the user doesn't care 
too much, he simply enjoys the ability to manage, search, and cross 
reference his content much more easily.

And then comes the "it's a user land thing" comment again.  And again 
the response.  When does moving this from user land into kernel land 
become a better choice.

With the file systems we have today, it's really not much of a gain 
compared to the cost of the move.

Consider Reiser4 now.  More and more meta data is being used in regards 
to files.  That margin is shrinking.

BeOS broached it, Microsoft is building it.  Just because they did it 
doesn't mean we have to do it nor that it is right.

But it's food for thought.  Especially as more and more tidbits get 
associated with files.

-david


--------------000901000907070902030504
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000901000907070902030504--
