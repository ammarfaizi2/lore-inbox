Return-Path: <linux-kernel-owner+w=401wt.eu-S1030293AbXAHWS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbXAHWS1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbXAHWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:18:26 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:60143 "EHLO ns2.lanforge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030289AbXAHWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:18:25 -0500
Message-ID: <45A2C32D.4080101@candelatech.com>
Date: Mon, 08 Jan 2007 14:18:21 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system went read-only in 2.6.18.2 (plus hacks)
References: <45A2B9DA.20104@candelatech.com> <20070108220544.0febd10b@localhost.localdomain>
In-Reply-To: <20070108220544.0febd10b@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> pktgen: pktgen_mark_device marking eth0#5 for removal
>> pktgen: pktgen_mark_device marking eth0#0 for removal
>> .....
>>
>> After restarting and a manual fsck, the system appears to
>> be back to normal.
> 
> Did the fsck find any errors ?

Yes.  They are below:

Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda1
CT_ROOT contains a file system with errors, check forced.
CT_ROOT: Directory inode 99041, block 0, offset 0: directory corrupted


CT_ROOT: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
         (i.e., without -a or -p options)
[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D to continue):
(Repair filesystem) 1 # fsck.ext3
anaconda-ks.cfg     .gconf/             .serverauth.7145
.bash_history       .gconfd/            .ssh/
.bash_logout        GNUstep/            .tcshrc
.bash_profile       .gtkrc              .vnc/
.bashrc             install.log.syslog  .Xauthority
.cshrc              .lesshst            .xauths0kLo8
.ethereal/          .serverauth.1869    .xinitrc
(Repair filesystem) 1 # fsck.ext3 -a -y /dev/hda1
e2fsck: Only one the options -p/-a, -n or -y may be specified.
(Repair filesystem) 2 # fsck.ext3 -y /dev/hda1
e2fsck 1.38 (30-Jun-2005)
CT_ROOT contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Directory inode 99041, block 0, offset 0: directory corrupted
Salvage? yes

First entry 'M-?' (inode=124909) in directory inode 99041 (???) should be '.'
Fix? yes

Setting filetype for entry '.' in ??? (99041) to 2.
Missing '..' in directory inode 99041.
Fix? yes

Setting filetype for entry '..' in ??? (99041) to 2.
Directory inode 99048, block 0, offset 0: directory corrupted
Salvage? yes

First entry 'M-?' (inode=129789) in directory inode 99048 (???) should be '.'
Fix? yes

Setting filetype for entry '.' in ??? (99048) to 2.
Missing '..' in directory inode 99048.
Fix? yes

Setting filetype for entry '..' in ??? (99048) to 2.
Directory inode 99247, block 0, offset 0: directory corrupted
Salvage? yes

First entry 'M-?' (inode=102335) in directory inode 99247 (???) should be '.'
Fix? yes

Setting filetype for entry '.' in ??? (99247) to 2.
Missing '..' in directory inode 99247.
Fix? yes

Setting filetype for entry '..' in ??? (99247) to 2.
Directory inode 99254, block 0, offset 0: directory corrupted
Salvage? yes

First entry 'M-?' (inode=112567) in directory inode 99254 (???) should be '.'
Fix? yes

Setting filetype for entry '.' in ??? (99254) to 2.
Missing '..' in directory inode 99254.
Fix? yes

Setting filetype for entry '..' in ??? (99254) to 2.
Pass 3: Checking directory connectivity
'..' in /lib/modules/2.6.18.2c3/kernel/drivers/mtd/maps (99041) is <The NULL inode> (0), .Fix? yes

'..' in /lib/modules/2.6.18.2c3/kernel/drivers/mtd/chips (99048) is <The NULL inode> (0),.Fix? yes

'..' in /home/lanforge/DB/day_352 (99247) is <The NULL inode> (0), should be /home/lanfor.Fix? yes

'..' in /home/lanforge/DB/day_353 (99254) is <The NULL inode> (0), should be /home/lanfor.Fix? yes

Pass 4: Checking reference counts
Inode 2 ref count is 19, should be 23.  Fix? yes

Inode 63506 ref count is 1, should be 2.  Fix? yes

Inode 95836 ref count is 58, should be 56.  Fix? yes

Unattached inode 99004
Connect to /lost+found? yes

Inode 99004 ref count is 2, should be 1.  Fix? yes

Unattached inode 99005
Connect to /lost+found? yes

Inode 99005 ref count is 2, should be 1.  Fix? yes

Unattached inode 99006
Connect to /lost+found? yes

Inode 99006 ref count is 2, should be 1.  Fix? yes

Unattached inode 99007
Connect to /lost+found? yes

Inode 99007 ref count is 2, should be 1.  Fix? yes

Unattached inode 99008
Connect to /lost+found? yes

Inode 99008 ref count is 2, should be 1.  Fix? yes

Unattached inode 99009
Connect to /lost+found? yes

Inode 99009 ref count is 2, should be 1.  Fix? yes

Unattached inode 99010
Connect to /lost+found? yes

Inode 99010 ref count is 2, should be 1.  Fix? yes

Unattached inode 99011
Connect to /lost+found? yes

Inode 99011 ref count is 2, should be 1.  Fix? yes

Unattached inode 99012
Connect to /lost+found? yes

Inode 99012 ref count is 2, should be 1.  Fix? yes

Unattached inode 99013
Connect to /lost+found? yes

Inode 99013 ref count is 2, should be 1.  Fix? yes

Unattached inode 99014
Connect to /lost+found? yes

Inode 99014 ref count is 2, should be 1.  Fix? yes

Unattached inode 99016
Connect to /lost+found? yes

Inode 99016 ref count is 2, should be 1.  Fix? yes

Unattached inode 99017
Connect to /lost+found? yes

Inode 99017 ref count is 2, should be 1.  Fix? yes

Unattached inode 99019
Connect to /lost+found? yes

Inode 99019 ref count is 2, should be 1.  Fix? yes

Inode 99020 ref count is 8, should be 6.  Fix? yes

Unattached inode 99021
Connect to /lost+found? yes

Inode 99021 ref count is 2, should be 1.  Fix? yes

Unattached inode 99022
Connect to /lost+found? yes

Inode 99022 ref count is 2, should be 1.  Fix? yes

Unattached inode 99023
Connect to /lost+found? yes

Inode 99023 ref count is 2, should be 1.  Fix? yes

Unattached inode 99248
Connect to /lost+found? yes

Inode 99248 ref count is 2, should be 1.  Fix? yes

Unattached inode 99249
Connect to /lost+found? yes

Inode 99249 ref count is 2, should be 1.  Fix? yes

Unattached inode 99250
Connect to /lost+found? yes

Inode 99250 ref count is 2, should be 1.  Fix? yes

Unattached inode 99251
Connect to /lost+found? yes

Inode 99251 ref count is 2, should be 1.  Fix? yes

Unattached inode 99252
Connect to /lost+found? yes

Inode 99252 ref count is 2, should be 1.  Fix? yes

Unattached inode 99253
Connect to /lost+found? yes

Inode 99253 ref count is 2, should be 1.  Fix? yes

Unattached inode 99255
Connect to /lost+found? yes

Inode 99255 ref count is 2, should be 1.  Fix? yes

Unattached inode 99256
Connect to /lost+found? yes

Inode 99256 ref count is 2, should be 1.  Fix? yes

Unattached inode 99257
Connect to /lost+found? yes

Inode 99257 ref count is 2, should be 1.  Fix? yes

Unattached inode 99258
Connect to /lost+found? yes

Inode 99258 ref count is 2, should be 1.  Fix? yes

Unattached inode 99259
Connect to /lost+found? yes

Inode 99259 ref count is 2, should be 1.  Fix? yes

Unattached inode 99260
Connect to /lost+found? yes

Inode 99260 ref count is 2, should be 1.  Fix? yes

Pass 5: Checking group summary information
Block bitmap differences:  +67611 -(79872--79873) -(80952--81007) -(81016--81023) -(810271Fix? yes


CT_ROOT: ***** FILE SYSTEM WAS MODIFIED *****
CT_ROOT: ***** REBOOT LINUX *****
CT_ROOT: 38495/253184 files (3.5% non-contiguous), 227976/253015 blocks
(Repair filesystem) 3 # reboot


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

