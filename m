Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLOWNx>; Fri, 15 Dec 2000 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbQLOWNo>; Fri, 15 Dec 2000 17:13:44 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:18182 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129383AbQLOWNe>; Fri, 15 Dec 2000 17:13:34 -0500
Message-Id: <4.3.2.7.2.20001215162135.00b47ed0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 15 Dec 2000 16:42:32 -0500
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: test13p1 - NFS module problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I just built test13-pre1 and have some unresolved nfs symbols.
Here's the relevant portion of .config:

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y

"make oldconfig dep bzImage modules" ran file.
"make modules_install" generated the following messages:

cd /lib/modules/2.4.0-test13p1; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0-test13p1; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test13p1/kernel/fs/nfs/nfs.o
depmod: 	lockd_up_Rf6933c48
depmod: 	nlmclnt_proc_R4a4f5767
depmod: 	lockd_down_Ra7b91a7b
depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test13p1/kernel/fs/nfsd/nfsd.o
depmod: 	nlmsvc_ops_R9b9f6a7f
depmod: 	nlmsvc_invalidate_client_Rb1c3f825
depmod: 	lockd_up_Rf6933c48
depmod: 	lockd_down_Ra7b91a7b

Anybody know the fix for this?

Full .config available if necessary...

David
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       514 W. Keech Ave.
www.osagesoftware.com          Ann Arbor, MI 48103
voice: 734.821.8800            fax: 734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
