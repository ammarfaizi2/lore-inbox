Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKYOOc>; Mon, 25 Nov 2002 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSKYOOc>; Mon, 25 Nov 2002 09:14:32 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:54543 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263366AbSKYOOb>; Mon, 25 Nov 2002 09:14:31 -0500
Message-ID: <3DE2320B.1A2F77B8@aitel.hist.no>
Date: Mon, 25 Nov 2002 15:22:03 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.49 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: jordan.breeding@attbi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.5.49 mount root again for devfs users
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does your patch break being able to mount root with things 
>like "root=/dev/discs/disc0/part9" 
>and/or "root=/dev/scsi/host0/bus0/id0/lun0/part9"?  For people with devfs 
>enable kernels those are valid boot entries and should not end up getting 
>broken needlessly.

I have devfs, and my /etc/lilo.conf contains this:

boot=/dev/ide/host0/bus0/target0/lun0/disc
root=/dev/ide/host0/bus0/target0/lun0/part4

I haven't tried to put this in a command line
option, but it works fine from lilo.

The reason fro the patch is that I couldn't boot
with devfs anymore, I'd get a 
"panic: couldn't mount root at 03:04"
or similiar, depending on which machine I used.

Now I don't get that, it just works.

Have you been able to boot a devfs-enabled
2.5.48 or later?  On a machine where /dev
is only a empty directory - a mountpoint
for devfs use?



Helge Hafting
