Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCBU0g>; Fri, 2 Mar 2001 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbRCBU0Z>; Fri, 2 Mar 2001 15:26:25 -0500
Received: from staffnet.com ([207.226.80.14]:26375 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S129478AbRCBU0N>;
	Fri, 2 Mar 2001 15:26:13 -0500
Message-ID: <3AA001DC.C11B688D@staffnet.com>
Date: Fri, 02 Mar 2001 15:26:04 -0500
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: apparent file corruption on 2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is a CC of a post I sent last night to the redhat-list.
I am forwarding it to the kernel list as I hear others
have had file corruption and this might be of interest....
Also, if anyone has any ideas....

I got a couple of responses including:

1)  Backup/restore the partition (in this case /)

2)  Try shutdown -F now then do an FSCK again

3)  There is something else you can do, but it's rather 
    radical.  Overwrite the entries directly in the 
    directory table.  You would have to write a program
    to do it, but it should solve the problem.
	Warren Melnick <warren.melnick@astata.com>

4)  From Kernel Traffic #107 For 16 Feb, item #3
    "I resorted to using debugfs to remove these entries, 
    and re-running e2fsck".    [I may try this tonight!]

System information:
	Dell PIII 600 with 20G ATAPI, ATAPI DVD, ZIP, CD-R
	IDE-SCSI loaded for CD-R, DVD
	3COM 3C905 100T NIC
	3dfx AGP video
	RedHat 7.0 with updates
	2.4.0 or 2.4.2 kernel, stock (no custom patches)

Original post follows:

I had some problems with shutting down my RH 7.0 box (2.4.0) and 
had to hit the reset button.  I then tried booting to 2.4.2 which 
I had just installed.  However, I got a lot of disk errors and 
the sizes on quite a few files were changed to 104.

A second hard reboot and startup of 2.4.0, a single user fsck of
all partitions and reboot seemed to make all well, however a 
couple of files are messed up, /bin/hostname and /dev/dsp.

I can't move, delete, or do anything with these files.  I tried 
chattr, touch, etc. and the only thing I can do is change the 
access date with touch.

b--sr-s--t    1 1769209956 1852796526 116, 101 May 29  2023
              /binold/hostname

prwxr-x--T    1 2232483836 2312881283        0 Mar  1 22:41 
              /dev/dsp

I recovered /bin by copying /bin/* to /binnew, moving /bin to 
/binold, then moving /binnew to /bin.  I then recovered 
/bin/hostname from the RPM file, but now I can't do anything 
with /binold/hostname....

I tried chattr, chmod, chgrp, mv, cat, vi, touch, etc.

Does anyone have any ideas.  I can live with one messed up file 
in /binold, but I can't live with a messed up /dev/dsp.  I 
really don't want the Microsoft solution (reload)....

Any help would be MOST appreciated!
--
Wade Hampton
