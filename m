Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbTCSKBn>; Wed, 19 Mar 2003 05:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbTCSKBn>; Wed, 19 Mar 2003 05:01:43 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:59153 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262977AbTCSKBl>; Wed, 19 Mar 2003 05:01:41 -0500
Message-ID: <3E784315.3060806@aitel.hist.no>
Date: Wed, 19 Mar 2003 11:14:45 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 471] New: Root on software raid don't boot on new 2.5 kernel
 since after 2.5.45
References: <779600000.1048059690@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=471
> 
>            Summary: Root on software raid don't boot on new 2.5 kernel since
>                     after 2.5.45

Root on raid-1 works fine for me, with and without devfs.  My kernel has
no module support, everything is compiled in.  I don't use initrd.
I have used root-raid with every 2.5 kernel except for a few that had
raid bugs. (Affecting all raid, the root weren't special.)

Until recently the root raid always did an unclean shutdown, but this didn't
cause other trouble than a bootup resync.

> Problem Description:
>  The software raid setup I have boots on 2.4 but not on newer 2.5 kernels, i
> have everything need compiled in and the 2.5 kernel also rapports that it has
> found /dev/md2 but it rapports that is's unable to mount the root partition for
> this device. I have tried to pass /dev/md0 as the root but this hangs the
> kernel, is root on raid broaken in kernel 2.5 or am I doing something wrong?
> 
>  lilo:
>   image=/boot/vmlinuz-2.4.21-pre1
>         label=linux
>         root=/dev/md2
>         read-only
>         append=" devfs=mount"
> 
>   image=/boot/vmlinuz-2.5.65
>         label=linux25
>         root=/dev/md2
>         read-only
>         append=" devfs=mount"

Are you using devfs?  I expect the name of the raid device
to be something like /dev/md/2 instead of /dev/md2 in that case.

Helge Hafting

