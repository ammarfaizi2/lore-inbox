Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTDOUaw (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTDOUav 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:30:51 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:29123 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S264067AbTDOUau 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:30:50 -0400
Message-ID: <3E9C6F10.10001@hccnet.nl>
Date: Tue, 15 Apr 2003 22:44:00 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

>On Sun, Apr 13, 2003 at 07:44:04PM +0200, Gert Vervoort wrote:
>
>Here is a patch against 2.5.67, can you try it out?
>
>I did not compile let alone run with this patch.
>  
>
The patch compiles and the warning messages are gone now.
But, I still can't mount a zip disk.

Kernel messages after mounting a zip disk (mount -t ext2 /dev/sda1 
/mnt/zip):

SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
 sda:

The kernel messages are showing twice, does it try to mount the zip disk 
two times?

At this point the mount process is stuck:

[root@viper root]# ps -ax | grep zip
  998 tty1     D      0:00 mount -t ext2 /dev/sda1 /mnt/zip
 1057 tty2     S      0:00 grep zip
[gert@viper root]$


    Gert




