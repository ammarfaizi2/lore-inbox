Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285505AbRLGUfN>; Fri, 7 Dec 2001 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLGUfE>; Fri, 7 Dec 2001 15:35:04 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:263 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S285505AbRLGUev>;
	Fri, 7 Dec 2001 15:34:51 -0500
Message-ID: <3C1127A4.6070701@namesys.com>
Date: Fri, 07 Dec 2001 23:33:40 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: cs@zip.com.au, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <20011207141913.A26225@zapff.research.canon.com.au> <3C109FE3.5070107@namesys.com> <E16CMN6-0000t8-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On December 7, 2001 11:54 am, Hans Reiser wrote:
>
>>Cameron Simpson wrote:
>>
>>>On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser <reiser@namesys.com> 
>>>
>wrote:
>
>>>| Have you ever seen an application that creates millions of files create 
>>>| them in random order?
>>>
>>>I can readily imagine one. An app which stashes things sent by random
>>>other things (usenet/email attachment trollers? security cameras taking
>>>thouands of still photos a day?). Mail services like hotmail. with a
>>>zillion mail spools, being made and deleted and accessed at random...
>>>
>>Ok, they exist, but they are the 20% not the 80% case, and for that 
>>reason preserving order in hashing is a legitimate optimization.
>>
>
>At least, I think you ought to make a random hash the default.  You're 
>suffering badly on the 'random name' case, which I don't think is all that 
>rare.  I'll run that test again with some of your hashes and see what happens.
>
>>If names are truly random ordered, then the only optimization that can 
>>help is compression so as to cause the working set to still fit into RAM.
>>
>
>You appear to be mixing up the idea of random characters in the names with 
>random processing order.  IMHO, the exact characters in a file name should 
>not affect processing efficiency at all, and I went out of my way to make 
>that true with HTree.
>

If the characters in the name determine the point of insertion, and the 
extent to which processing order correlates with the point of insertion 
determines how well caching works, then do you see my viewpoint?

Sure, nobody "should" have to engage in locality of reference, but God 
was not concerned somehow, and so disk drives make us get all very 
worried about locality of reference.

>
>
>On the other hand, the processing order of names does and will always matter 
>a great deal in terms of cache footprint.
>
>I should have done random stat benchmarks too, since we'll really see the 
>effects of processing order there.  I'll put that on my to-do list.
>
>--
>Daniel
>
>
We should give Yura and Green a chance to run some benchmarks before I 
get into too much analyzing.  I have learned not to comment before 
seeing complete benchmarks.

Hans


