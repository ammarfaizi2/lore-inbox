Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRBBVeH>; Fri, 2 Feb 2001 16:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbRBBVd5>; Fri, 2 Feb 2001 16:33:57 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:46019 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129242AbRBBVdo>; Fri, 2 Feb 2001 16:33:44 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102022133.f12LXO319901@devserv.devel.redhat.com>
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 2 Feb 2001 16:33:24 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), mason@suse.com (Chris Mason),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <3A7B1BFA.F7B4EAD@namesys.com> from "Hans Reiser" at Feb 02, 2001 11:43:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Users cannot use gcc 2.96 as shipped in RedHat 7.0 if they want to use
> reiserfs.  It is that simple.  How can you even consider defending allowing the
> use of it without requiring a positive affirmation by the user that they don't
> know what they are doing and want to do it anyway?:-)  I could understand

The kernel documentation explicitly says to use egcs-1.1.2 or 2.95 for x86.
If you want to put in #ifdefs then let me assure you that you will then get
a million emails that 'reiserfs doesnt build'. I went this way with older
gcc's in 2.0 and the amount of mail more than doubled by doing the check

If people use other compilers then certainly ignore the bug reports. For 2.2
until recently that was policy with gcc 2.95 

Also remember to check for 2.96 but not 2.96-69 (the errata one) and remember
to do specific architecture tests as there is no other compiler set available
for IA64 for example.

> to respond to their having them.  I look forward to gcc 3.00, and I encourage
> the compiler guys to get over being (understandably) irked that somebody else

Gcc 3.0 CVS branch wont build the kernel either right now - DAC960 fails.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
