Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSDDAGw>; Wed, 3 Apr 2002 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312515AbSDDAGm>; Wed, 3 Apr 2002 19:06:42 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:59652 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312505AbSDDAGZ>; Wed, 3 Apr 2002 19:06:25 -0500
Message-ID: <3CAB98F4.9080809@ngforever.de>
Date: Wed, 03 Apr 2002 17:06:12 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David D. Hagood" <wowbagger@sktc.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020403140516.C38235-100000@toad.stack.nl> <3CAAFA36.80109@sktc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David D. Hagood wrote:
> Jos Hulzink wrote:
> 
>> How should the FAT driver know that the first FAT is bad if it doesn't
>> scan the FAT ? You don't want the second FAT to be used, you want the
>> mount to fail, and fsck.xxx to fix the mess. Who tells you that the 
>> second
>> copy of the FAT is the correct one, and not the first ?
> 
> 
> Seems to me you would want a mount-time option to the FAT fs code to say 
> "use FAT#<n>", defaulting to the first if no parm given. If that copy of 
> the FAT has any problems, fail the mount.
> 
> Then you'd want the fsck.fat to have a similar option, saying "use 
> FAT#<n> for the check" - that way if the FATs are out of sync, you could 
> do a dry run check on each FAT, and go with the one that seemed to be 
> better. Perhaps even having the tool allow you to pick and choose if 
> needed (although this would probably be better as a seperate tool, that 
> allowed you to view a file given a selected FAT and copy it to a clean 
> file system.)
If I apply the "Think big" patch for a second, I say, check individually 
for each entry with fsck.fat and build a fat of the entries that are 
still ok. This could be a special --rebuild option or whatever.

Regards,
Thunder
-- 
Thunder from the hill.
Citizen of our universe.

