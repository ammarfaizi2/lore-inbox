Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270036AbRHQKGO>; Fri, 17 Aug 2001 06:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270042AbRHQKGE>; Fri, 17 Aug 2001 06:06:04 -0400
Received: from camus.xss.co.at ([194.152.162.19]:55058 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S270036AbRHQKFu>;
	Fri, 17 Aug 2001 06:05:50 -0400
Message-ID: <3B7CEC89.642FB425@xss.co.at>
Date: Fri, 17 Aug 2001 12:06:01 +0200
From: Daniel Wagner <daniel.wagner@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initrd: couldn't umount
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

we try to setup an initrd for diskless nodes, which allows us a
modular kernelconfiguration (especially the net-drivers). it work
quite well, but ...

the problem is that a "rpciod" kernel-thread references the initrd,
and so umounting and freeing it, isn't possible.

has anybody an idea how to fix this problem, cause it would be nice,
to free the initrd ram on a diskless node.

this is what comes after processing the initrd:

---
Looking up port of RPC 100003/2 on 192.168.162.201
Looking up port of RPC 100005/1 on 192.168.162.201
VFS: Mounted root (NFS filesystem).
change_root: old root has d_count=3
Mounted devfs on /dev
Trying to unmount old root ... <3>error -16
Change root to /initrd: error -2
Freeing unused kernel memory: 56k
freed                                                                                                    
---

Regards,
  Daniel

-- 
Daniel Wagner                      | mailto:daniel@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
