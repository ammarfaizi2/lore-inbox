Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRD1DXZ>; Fri, 27 Apr 2001 23:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRD1DXP>; Fri, 27 Apr 2001 23:23:15 -0400
Received: from james.kalifornia.com ([208.179.59.2]:10550 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S135519AbRD1DXE>; Fri, 27 Apr 2001 23:23:04 -0400
Message-ID: <3AEA377C.8090005@blue-labs.org>
Date: Fri, 27 Apr 2001 20:22:36 -0700
From: david <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-pre6 i686; en-US; rv:0.8.1+) Gecko/20010426
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: jason <jason@lacan.dabney.caltech.edu>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.x and reiserfs
In-Reply-To: <Pine.LNX.4.10.10104270104010.7570-100000@lacan.dabney.caltech.edu> <3AE9913B.6090208@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To your complaint, I have to add my kudos.  I frequently run into 
crashes and I have only had reiserfs filesystem that I had to rebuild in 
well over a year of using it on half a dozen workstations.  I use 2.4 
exclusively and have often had "premature restarts".

David

Tony Hoyle wrote:

> jason wrote:
>
>> Hello,
>>
>> As the subject would imply, I've been having problems with 2.4.x. I have
>> my root partition (/dev/hda1) as reiserfs and also have another 
>> harddrive
>> with a reiserfs partition (/dev/hdc1). Several programs write (e.g. save
>> files to) /dev/hdc1, and I also store files there. Under 2.4.2, whenever
>> manually copying files from hda1 to hdc1, I would get a kernel panic, 
>> the
>
>
>
> Reiserfs doesn't cope well with crashes....  Under 2.4 I wouldn't 
> recommend using it on any kind of critical server - it seems to 
> progressively corrupt itself (I'm looking at the second reformat and 
> reinstall in a week, and I'm not a happy bunny).
>
> As the warning on reiserfsck says, the rebuild-tree option is a last 
> resort.  It's as likely to make the problem worse then improve it (It 
> rounds all the file lengths up to a block size, padding with zeros, 
> which breaks lots of stuff).  Backup what you can first.
>
> I find that if you run reiserfsck -x /dev/hda1 a couple of dozen times 
> it slowly fixes stuff that it couldn't fix on the previous pass.One 
> thing that can't fix is the bug that seems to make random files on the 
> FS unreadable even for root.The only way I've found around that one is 
> a periodic format/reinstall.
>
> Tony
>



