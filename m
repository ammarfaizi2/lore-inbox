Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbREBR3E>; Wed, 2 May 2001 13:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135670AbREBR2y>; Wed, 2 May 2001 13:28:54 -0400
Received: from chicago.cheek.com ([64.16.171.55]:12810 "EHLO chicago.cheek.com")
	by vger.kernel.org with ESMTP id <S135659AbREBR2w>;
	Wed, 2 May 2001 13:28:52 -0400
Message-ID: <3AF0438E.2090709@cheek.com>
Date: Wed, 02 May 2001 10:27:42 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; 0.8.1) Gecko/20010403
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug: can't mount -o loop or -t nfs in 2.4.4, 2.4.4-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.4-pre7 worked fine.

situation:

mounting a remote nfs share or a loopback local filesystems doesn't 
work.  it doesn't crash the system, the userspace process just hangs on 
the mount() call.

all of these hang:

# mount -o loop /my/ext2/image /mnt/ext2
# mount -o loop /my/fat16/image /mnt/fat16
# mount -o loop /my/iso9660/image /mnt/iso
# mount other.system:/export /import

mounting local drives works fine, as long as it isn't nfs - i can mount 
my ext2 and vfat drives, but not a local export on the same local machine.

i can give strace output if desired.  please help!

thanks!

joe

