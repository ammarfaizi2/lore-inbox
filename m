Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313644AbSDEV5L>; Fri, 5 Apr 2002 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313640AbSDEV5B>; Fri, 5 Apr 2002 16:57:01 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:18320 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S313560AbSDEV4s>; Fri, 5 Apr 2002 16:56:48 -0500
Date: Fri, 5 Apr 2002 23:56:47 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: fsck on ext3 after 20 mounts reports i_blocks=n should be m
Message-ID: <20020405235647.A29670@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

My laptop which runs 2.5.6 today decided to fsck / because it had been
mounted 20 times. During those 20 times I think it had in the order of 5
unclean shutdowns (empty battery mostly), all of them running 2.5.6
according to 'last'.

The fsck reports, from what I can recall:

inode X i_blocks=n, should be m. FIXED

About 8 of these. M is always smaller than n. The difference appeared to be
always a multiple of 8. One case was '32, should be 24'. Another was '80,
should be 8'. Larger differences were reported too.

The fs appears to work just fine though. If there is any other information
you need, just let me know.

# tune2fs -l /dev/hda1
tune2fs 1.27 (8-Mar-2002)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          0a30dec8-3356-43a6-a9cd-f26e86fc5321
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              611648
Block count:              1220932
Reserved block count:     61046
Free blocks:              167112
Free inodes:              455973
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16096
Inode blocks per group:   503
Last mount time:          Fri Apr  5 23:45:33 2002
Last write time:          Fri Apr  5 23:45:33 2002
Mount count:              1
Maximum mount count:      20
Last checked:             Fri Apr  5 23:45:22 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Oct  2 23:45:22 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128
Journal UUID:             <none>
Journal inode:            351
Journal device:	          0x0000
First orphan inode:       36051

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
