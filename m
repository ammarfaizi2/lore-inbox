Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQL1Is2>; Thu, 28 Dec 2000 03:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129931AbQL1IsS>; Thu, 28 Dec 2000 03:48:18 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:6058 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129552AbQL1IsE>; Thu, 28 Dec 2000 03:48:04 -0500
To: linux-kernel@vger.kernel.org
Subject: DOS vm86 not working?
From: Gregory Stark <gsstark@mit.edu>
Date: 28 Dec 2000 03:16:49 -0500
Message-ID: <87u27prmdq.fsf@localhost.freelotto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried dosemu again after upgrading to 2.4.0pre11, and it ran my program
about halfway and then started spinning with strace reporting:

vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)
vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)
vm86(0x1, 0x811f540, 0xa6, 0xfff8fff1, 0x81d30a4) = -1 ENOSYS (Function not implemented)

I don't see any reason in the source why vm86 would report ENOSYS except if
the system call simply wasn't present. I'm not really familiar with this
source though so I could be missing something. Is there something wrong with
the vm86 code and it's just always returning ENOSYS now?

I haven't tried this program in 2.2 yet, I'll have to do that next time I get
a chance to reboot.

-- 
greg

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
