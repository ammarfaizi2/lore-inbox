Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJCT6X>; Thu, 3 Oct 2002 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJCT6W>; Thu, 3 Oct 2002 15:58:22 -0400
Received: from hokua.cfht.hawaii.edu ([128.171.80.51]:21942 "EHLO
	hokua.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S261186AbSJCT6U>; Thu, 3 Oct 2002 15:58:20 -0400
Message-ID: <3D9CA1C7.2000405@cfht.hawaii.edu>
Date: Thu, 03 Oct 2002 10:00:07 -1000
From: Kanoalani Withington <kanoa@cfht.hawaii.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: jbradford@dial.pipex.com, jakob@unthought.net,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RAID backup
References: <200210031120.g93BKLqK000216@darkstar.example.net> <200210031326.47386.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to pipe in here and agree that the idea of using a disk array 
alone for backups is not a sound idea. Sure, backing up 2Tb to an old 
exabyte drive isn't going to work, if you really have that much data you 
need some more modern equipment.

Essentially I believe the idea of a redundant array sounds safer than it 
really is in practice, especially when dealing with very large arrays 
and with level 5 arrays. The reasons why this is so are manifold, 
suffice to say that a few years of actually using such devices shows 
that they have much more potential for catastrophic failure and latent 
failure (you don't know it's broken until you go to use it and find out 
it's broken) than a well designed tape archive or backup.

Not that disk to disk backups are a completely bad idea. In my 
experience a combination works best. For example, automatic backups to 
reserved disks or disk arrays on remote systems every night, but once a 
week tape snapshots of that data. It's a lot of tapes but over time it 
will prove to be worthwhile. If the data volume is too high, simple 
backup scripts that write every file only once (essentially an archive) 
to tape to make it more practical.

-Kanoa


Roy Sigurd Karlsbakk wrote:

>On Thursday 03 October 2002 13:20, jbradford@dial.pipex.com wrote:
>
>>Might it not be a good idea to DD the raw contents of each disk to a tape
>>drive, just incase you fubar the array?  It would be time consuming, but at
>>least you could restore your data in the event that it gets corrupted.
>>
>
>er
>
>16 120GB disks?
>


