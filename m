Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCKSqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCKSqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVCKSor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:44:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2192 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261288AbVCKSlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:41:08 -0500
Message-ID: <4231E75A.4090203@tmr.com>
Date: Fri, 11 Mar 2005 13:45:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <20050309111102.GA30119@elf.ucw.cz><20050309111102.GA30119@elf.ucw.cz> <20050309235716.GZ3163@waste.org>
In-Reply-To: <20050309235716.GZ3163@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Mar 09, 2005 at 12:11:02PM +0100, Pavel Machek wrote:
> 
>>On St 09-03-05 09:52:46, Marcos D. Marado Torres wrote:
>>
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>On Wed, 9 Mar 2005, Greg KH wrote:
>>>
>>>
>>>>which is a patch against the 2.6.11.1 release.  If consensus arrives
>>>>that this patch should be against the 2.6.11 tree, it will be done that
>>>>way in the future.
>>>
>>>IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt 
>>>againt
>>>the last -rc but against 2.6.x.
>>
>>You expect people to go through all 2.6.11.1, 2.6.11.2, ... . That
>>means .11.2 should be relative to .11.1, because otherwise people will
>>have to revert (ugly). And you want people to track -stable kernels as
>>fast as possible.
> 
> 
> There are three ways we can do this:
> 
> a) all 2.6.x.y are diffs against 2.6.x
> b) interdiffs for .1, .2, etc. with 2.6.x+1 diffed against 2.6.x
> c) interdiffs and 2.6.12 is a diff against 2.6.11.last
> 
> Imagine we want to go from 2.6.11.3 to 2.6.12
> 
> case a)
> revert patch 2.6.11.3
> get and apply 2.6.12

Would anyone actually do that? About the time of the first patch usually 
do something like:
   cd linux-2.6.11
   cp -rl . ../linux-2.6.11.1
   cd $_
   bzcat ../Patches/patch-2.6.11.1.bz2 | patch -p1
   make oldconfig

By doing copy with links for all unchanged files you use virtually no 
extra space for each revision, and that encourages creating a separate 
tree for testing patches from -ck, or -ac, or Nick.

I use it to compile with various options as well, I usually build test 
versions for P-II, P-III, P4-HT and Athlon depending on what I'm testing.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
