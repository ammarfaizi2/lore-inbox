Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTC0Vk4>; Thu, 27 Mar 2003 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbTC0Vk4>; Thu, 27 Mar 2003 16:40:56 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:16093 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S261384AbTC0Vkz>; Thu, 27 Mar 2003 16:40:55 -0500
Date: Thu, 27 Mar 2003 16:52:08 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: can't mount ("invalid client credential") remote volume
Message-Id: <20030327165208.6a819196.fryman@cc.gatech.edu>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; sparc-sun-solaris2.8)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

it appears this type of error hasn't been seen since the late 90's or so,
and the fix then doesn't apply to now.  i tried this first on linux-net,
but go no response, so i thought i'd try LKML.

i have a remote-mountable HP logic analyzer (HP 16500B) that provides an 
NFS export at /control and /data.  network-wise, it's configured fine -- 
it can talk to the world, the world can talk to it via ping, telnet, and
ftp.

where it's falling down is when i try to NFS mount the spaces:

   root@hammett # mount hp16500b:/control /mnt/16500b/control/
   mount: RPC: Authentication error; why = Invalid client credential

i've tried playing with "-o nfsvers=2" and such, but nothing i do seems
to really change it.  way back in '95-'98, there was some discussion 
about seeing this error on occasion.  the answer was to be sure "root"
didn't belong to >= 8 groups.  on the PC (modified RH8) that's not
an issue.  root belongs to 4 groups.

obviously on the HP box, there's very little i can configure.  the idea
of "root" doesn't even exist.

does anyone have any suggestions for how to get around this problem?

thanks,

josh fryman
