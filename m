Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbQKLQuC>; Sun, 12 Nov 2000 11:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQKLQtw>; Sun, 12 Nov 2000 11:49:52 -0500
Received: from london.rubylane.com ([208.184.113.40]:52460 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S129159AbQKLQtm>; Sun, 12 Nov 2000 11:49:42 -0500
Message-ID: <20001112164941.14930.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: IDE tape problem in 2.2.17 on Intel SMP
To: gadio@netvision.net.il
Date: Sun, 12 Nov 2000 08:49:41 -0800 (PST)
Cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on Nov 2nd about IDE tapes no longer working in 2.2.17.  The
write seems to work fine, but the verify pass causes read errors and
a tar abort.

I tried changing the priority of the tar process to higher than all
others (it was running as a very low priority job and I thought that
might be a contributing factor), but the higher priority did not help.

I tried restoring the last file from the tape.  One day it failed with
an "unexpected EOF" error, the next day it restored the file correctly
(even though we got the 12 read errors on the verify pass and tar
aborted).

My conclusion is that the tape write is working.  The drive has
hardware read after write verification, so I kinda thought this was
the case.  But IDE tape reads appear to be flakey on an active SMP
setup (Intel).  This problem started the day we switched from 2.2.16
to 2.2.17, without any other software or hardware changes.

If I can be of any further help, let me know.

Thanks,
Jim Wilcoxson
Owner, www.rubylane.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
