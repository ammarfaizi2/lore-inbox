Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTBXR5x>; Mon, 24 Feb 2003 12:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTBXR5x>; Mon, 24 Feb 2003 12:57:53 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:21711 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267159AbTBXR5v>; Mon, 24 Feb 2003 12:57:51 -0500
Subject: Re: 2.5.62-mm3 won't mount root
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030223230023.365782f3.akpm@digeo.com>
References: <20030223230023.365782f3.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Feb 2003 11:04:24 -0700
Message-Id: <1046109864.6615.153.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 00:00, Andrew Morton wrote:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm3/

2.5.62-mm3 won't mount root for me.
2.5.62-bk-current (as of 2 hours ago) works fine.

I get this right after setting the hostname:

Checking root filesystem
/dev/hda1
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock.
   e2fsck -b 8193 <device>

fsck.ext3 : No such file or directory while trying to open /dev/hda1
Failed to check filesystem.  Do you want to repair the errors? (Y/N)
(beware, you can lose data)

Even though this is just a test box, I chickened out and reset the box.

/def/hda1 is ext3:

[steven@spc1 steven]$ df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    236M  138M   87M  62% /
/dev/hda9     ext3     20G   13G  6.7G  67% /home
/dev/hda11     jfs    3.9G  2.7G  1.3G  68% /share_jfs
/dev/hda10
          reiserfs    4.0G  254M  3.7G   7% /share_reiser
/dev/hda12     xfs    4.8G  290M  4.5G   6% /share_xfs
/dev/hda8     ext3    236M  4.8M  219M   3% /tmp
/dev/hda6     ext3    2.9G  1.5G  1.3G  54% /usr
/dev/hda7     ext3    479M   66M  389M  15% /var

I tried to build 2.5.62-mm2, but couldn't do to this:

fs/devfs/fs.c: In function `devfs_event':
fs/devfs/fs.c:63: too few arguments to function `call_usermodehelper'
make[2]: *** [fs/devfs/fs.o] Error 1

Steven



