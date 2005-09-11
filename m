Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVIKGJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVIKGJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVIKGJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:09:02 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:36063 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S964777AbVIKGJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:09:00 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Sat, 10 Sep 2005 23:08:36 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
In-Reply-To: <20050911030726.GA20462@suse.de>
Message-ID: <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
 <20050911030726.GA20462@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Greg KH wrote:

> On Sat, Sep 10, 2005 at 05:48:05PM -0700, David Lang wrote:
>> On Fri, 9 Sep 2005, Greg KH wrote:
>>
>>> Here are the same "delete devfs" patches that I submitted for 2.6.12.
>>> It rips out all of devfs from the kernel and ends up saving a lot of
>>> space.  Since 2.6.13 came out, I have seen no complaints about the fact
>>> that devfs was not able to be enabled anymore, and in fact, a lot of
>>> different subsystems have already been deleting devfs support for a
>>> while now, with apparently no complaints (due to the lack of users.)
>>
>> do you really think that there have been that many people who have shifted
>> to 2.6.13 in less then 2 weeks since release?
>
> Ok, how long should I wait then?

if 2.6.13 removed the devfs config option, then I would say the code 
itself should stay until 2.6.15 or 2.6.16 (if the release schedule does 
drop down to ~2 months then it would need to be at lease .16). especially 
with so many people afraid of the 2.6 series you need to wait at least one 
full release cycle, probably two (and possibly more if they end up being 
short ones) then rip out the rest of the code for the following release.

remember that the distros don't package every kernel, they skip several 
between releases and it's not going to be until they go to try them that 
all the kinks will get worked out.

add to this the fact that many people have gotten confused about kernel 
releases and think that since 13 is odd 2.6.13 is a testing kernel and 
2.6.14 will be a stable one and so won't look at .13

note that all this assumes that the issues that people have about sysfs 
not yet being able to replace that capabilities that they are useing in 
devfs have been addressed.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
