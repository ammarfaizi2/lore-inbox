Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbRLBTbv>; Sun, 2 Dec 2001 14:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282600AbRLBTbn>; Sun, 2 Dec 2001 14:31:43 -0500
Received: from ubermail.mweb.co.za ([196.2.53.169]:32010 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S282511AbRLBTba>; Sun, 2 Dec 2001 14:31:30 -0500
Message-ID: <3C0A83B6.5060209@mweb.co.za>
Date: Sun, 02 Dec 2001 21:40:38 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
Reply-To: bonganilinux@mweb.co.za
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr> <9u9qas$1eo$1@penguin.transmeta.com> <200112010701.fB171N824084@vindaloo.ras.ucalgary.ca> <3C0898AD.FED8EF4A@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using Mandrake 8.1 (I think it loads devfs on startup)
I have compiled  2.4.17-pre1 and i get the same oops.

Pierre Rousselet wrote:

> Richard Gooch wrote:
> 
>>Linus Torvalds writes:
>>
>>>In article <3C085FF3.813BAA57@wanadoo.fr>,
>>>Pierre Rousselet  <pierre.rousselet@wanadoo.fr> wrote:
>>>
>>>>As far as I can see,
>>>>
>>>>when CONFIG_DEBUG_KERNEL is set
>>>> and
>>>>when devfsd is started at boot time
>>>>I get an Oops when remounting, rw the root fs :
>>>>
>>>>Unable to handle kernel request at va 5a5a5a5e
>>>>
>>>POISON_BYTE is 0x5a. Something in devfs is using a pointer from a data
>>>structure that was already free'd, and was thus corrupted by poisoning.
>>>
>>>(the above is almost certainly just a pointer dereference off 0x5a5a5a5a
>>>with an offset of 4 for some entry at the beginning of a structure,
>>>which is why you get the final "5e" in the page fault address).
>>>
>>>
>>>>It boots OK with devfsd when CONFIG_DEBUG_KERNEL is not set.
>>>>It boots OK without devfsd when CONFIG_DEBUG_KERNEL is set (then devfsd
>>>>can be started after login).
>>>>
>>>Well, not poisoning the free'd memory makes it "work" only in the sense
>>>that usually the free'd memory hasn't been re-allocated yet, so you
>>>don't see the bug even if it is still there.
>>>
>>>Richard Gooch probably wants a full stack trace, with symbols. Which
>>>should show it fairly clearly. At least EIP and the first few "stack
>>>trace" entries..
>>>
>>Indeed I do. Please Cc: me on devfs related stuff. And please apply
>>devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
>>knowing the behaviour with 2.4.17-pre1.


<snip very long config file>
.......
</snip>

I am using Mandrake 8.1 (I think it loads devfs on startup)
I have compiled  2.4.17-pre1 and i get the same oops.
2.4.16-pre1 does not seem to have a problem. I will try
2.4.17-pre2 and see how it goes.
-Bongani


