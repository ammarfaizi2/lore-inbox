Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319102AbSIJMJP>; Tue, 10 Sep 2002 08:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319103AbSIJMJP>; Tue, 10 Sep 2002 08:09:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:27153 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319102AbSIJMJO>; Tue, 10 Sep 2002 08:09:14 -0400
Message-ID: <3D7DE25F.3269EBF7@aitel.hist.no>
Date: Tue, 10 Sep 2002 14:15:27 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, Jens Axboe <axboe@suse.de>,
       andre@linux-ide.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Missing IDE partition 3 of 3 on 2.5.34?
References: <20020910054147.C86272C1FD@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
[...]
>          /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> 
> But it doesn't seem to have registered the third partition (/usr):
> 
>         (none):~# cat /proc/partitions
>         major minor  #blocks  name
> 
>            3     0   19938240 ide/host0/bus0/target0/lun0/disc
>            3     1     489951 ide/host0/bus0/target0/lun0/part1
>            3     2     128520 ide/host0/bus0/target0/lun0/part2
>            3     3   19318162 hda3
> 
>         (none):~# ls -l /dev/ide/host0/bus0/target0/lun0/
>         disc   part1  part2
> 
> Devfs issue?  IDE screwage?

I see the same thing.  Both of my IDE drives comes up without
the last partition. (Missing ide/host0/bus0/target0/lun0/part3
and ide/host0/bus1/target0/lun0/part7, loosing /usr and /usr/src
in my case.)

There's lots of updates in code that deals with partitions
and devfs, I couldn't find anything obvious wrong though.

Helge Hafting
