Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRJLWAk>; Fri, 12 Oct 2001 18:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278166AbRJLWAa>; Fri, 12 Oct 2001 18:00:30 -0400
Received: from wcgate.twi.com ([64.236.243.243]:8554 "EHLO
	wbsmtphost.wb-mail.com") by vger.kernel.org with ESMTP
	id <S278163AbRJLWA0>; Fri, 12 Oct 2001 18:00:26 -0400
Message-ID: <3BC76818.BA84A90E@wbfa.com>
Date: Fri, 12 Oct 2001 15:00:56 -0700
From: Alan Hagge <ahagge@wbfa.com>
Organization: Warner Brothers Animation
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS issue: Irix server, Linux client - inode number mismatch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have an SGI Irix 6.5-based server running NFS3 with Linux 2.4.7
clients attaching.  Whenever the server crashes, the Linux clients have
problems with their NFS mounts. Typically, they're unusable until after
reboot.

The /var/log/messages file on the Linux client side has the following
messages: 

        Oct  8 16:01:27 lrender2 automount[22485]: expired
/usr/local/sgi/wbfa 
        Oct  8 16:01:27 lrender2 kernel: nfs_refresh_inode: inode number
mismatch 
        Oct  8 16:01:27 lrender2 kernel: expected (0x3000007/0x6467c36),
got (0x3000005/0x6467c36) 
        Oct  8 16:06:27 lrender2 automount[22486]: expired
/usr/local/sgi/wbfa 
        Oct  8 16:06:27 lrender2 kernel: nfs_refresh_inode: inode number
mismatch 
        Oct  8 16:06:27 lrender2 kernel: expected (0x3000007/0x6467c36),
got (0x3000005/0x6467c36) 
        Oct  8 16:11:27 lrender2 automount[22487]: expired
/usr/local/sgi/wbfa 
        Oct  8 16:11:27 lrender2 kernel: nfs_refresh_inode: inode number
mismatch 
        Oct  8 16:11:27 lrender2 kernel: expected (0x3000007/0x6467c36),
got (0x3000005/0x6467c36) 

Can anyone tell me if this is expected behavior, and if not, if the
problem is in the Irix NFS server implementation or the 
Linux client implementation?  I don't have the NFS expertise to be able
to discern...

BTW, other clients (SGI Irix and Mac OS X workstations) connected to the
same mount points do NOT exhibit this 
behaviour after a server crash.

I checked the changelog at
http://www.fys.uio.no/~trondmy/src/ChangeLog.NFSv3 but didn't see
anything relevant.

Thanks,

Alan Hagge

Replies via cc:, please...
