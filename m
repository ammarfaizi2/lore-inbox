Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbQKAMXr>; Wed, 1 Nov 2000 07:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130527AbQKAMXh>; Wed, 1 Nov 2000 07:23:37 -0500
Received: from smtp-abo-2.wanadoo.fr ([193.252.19.150]:26079 "EHLO
	amyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130470AbQKAMXa>; Wed, 1 Nov 2000 07:23:30 -0500
Date: Wed, 1 Nov 2000 13:33:07 +0100
To: linux-kernel@vger.kernel.org
Cc: riel@nl.linux.org, andrea@e-mind.com
Subject: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001101133307.A10265@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using a 2.2.17 kernel I often experience problems where I get messages like
"VM: do_try_to_free_pages failed for <some process>", and the machine hangs
until the VM can recover, which sometimes takes too long for me to wait.  I
suppose that the problem is similar sometimes when I get a frozen system
under X, but can't see the kernel messages then.

Yesterday I could reproduce this at will, with a "make -j50" on 2.2.17
sources (as unpriviledged user).  In less than half an our syslogd stopped
to log anything (at 00:38), and this morning I could only see those messages
trying to free pages for (or from ?) wwwoffled.  Last load see by "top" on
another VC was ~74.

Have some work been done for 2.2.18 that could help me ?  Are there some
2.2-based VM patches that could help (I found the VM-global patch from
Andrea but have no info about what it is, and could not find 2.2-based
patches on Rik's pages) ?

Also I can't be sure for now I don't run into a hw problem...

I'm willing to investigate, but clearly lack experience in the VM...

Regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
