Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282289AbRKWXz4>; Fri, 23 Nov 2001 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282295AbRKWXy4>; Fri, 23 Nov 2001 18:54:56 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:44817 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282289AbRKWXyv>;
	Fri, 23 Nov 2001 18:54:51 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: viro@math.psu.edu
Date: Sat, 24 Nov 2001 00:54:10 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.5.0 breakage even with fix?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A0A71547524@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,
  I'm now running 2.5.0 with fix you posted - and now during dselect
run I received:

Unpacking replacement manpages ...
EXT2-fs error (device ide0(3,3)): ext2_check_page: bad entry in directory
  #3801539: unaligned directory entry - offset=0, inode=1801675088,
  rec_len=26465, name_len=101
Remounting filesystem read-only
rm: cannot remove directory `/var/lib/dpkg/tmp.ci': Read-only file system
...

and system is obviously unusable. I'll probably reboot and run fsck again.
If someone can show me how I can dump contents of some inode by number
(and not by name) in debugfs, I can look into inode itself... I found
only 'ncheck', to convert number to name, and this is running and running...

System was running 2.5.0 without patch for some time, but I followed
your guidelines for rebooting:

fuser -k /
sync
mount -o remount,ro /
sync
reboot

After reboot fsck was NOT run, so it is possible that there
might be some corruption - but I ran fsck on my non-root partition
after boot, and it did not show any problems.
                                        Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
                                                    
