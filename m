Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSEFU42>; Mon, 6 May 2002 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEFU41>; Mon, 6 May 2002 16:56:27 -0400
Received: from signup.localnet.com ([207.251.201.46]:60063 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S315171AbSEFU4Z>;
	Mon, 6 May 2002 16:56:25 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 (bk) nfsroot.c
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 06 May 2002 16:56:19 -0400
Message-ID: <m3k7qhdmh8.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this:

--- linux-2.4/fs/nfs/nfsroot.c   Sun May  5 14:09:00 2002
+++ linux-2.5/fs/nfs/nfsroot.c Sat May  4 04:29:03 2002
@@ -343,8 +374,8 @@
 {
        struct sockaddr_in sin;
 
-       printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-               program, version, in_ntoa(servaddr));
+       printk(KERN_NOTICE "Looking up port of RPC %d/%d on %u.%u.%u.%u\n",
+               program, version, NIPQUAD(servaddr));
        set_sockaddr(&sin, servaddr, 0);
        return rpc_getport_external(&sin, program, version, proto);
 }


Got missed in the 2.4 bk tree when in_ntoa was replaced by NIPQUAD.

As you can see from the patch, it already is in 2.5.

-JimC

