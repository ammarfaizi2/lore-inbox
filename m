Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRBLFc1>; Mon, 12 Feb 2001 00:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRBLFcI>; Mon, 12 Feb 2001 00:32:08 -0500
Received: from smtp.mountain.net ([198.77.1.35]:32522 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129910AbRBLFb7>;
	Mon, 12 Feb 2001 00:31:59 -0500
Message-ID: <3A877530.FF24A9F7@mountain.net>
Date: Mon, 12 Feb 2001 00:31:28 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Athlon-SMP final
Content-Type: multipart/mixed;
 boundary="------------1056C6A010D8CFA7C8DA9E0F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1056C6A010D8CFA7C8DA9E0F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan,

The polishing is done. Versus 2.4.1 again.

Summary:
	struct task_struct{...} moved to a new file, linux/task_struct.h.
	struct sigpending{...} moved to a new file, linux/sigpending.h.
	remove line linux/capability.c:17 #include <linux/fs.h> (blessed by Andrew
Morgan)
	adjust header inclusions in CONFIG_X386_USE_3DNOW section of
asm-i386/string.h.

Changes from the first version of the patch:
	revert creation of linux/mm_struct.h (needless)
	improve comments in the new files
	remove #ifdef guards around dummy declarations (suggested by Manfred
Spraul)
	remove dead version of kernel_cap_t support (also Manfred)
	remove redundant #include's (Niels Kristian Bech Jensen)

The new task_struct.h may be useful to others. If linux/sched.h is included
just to permit dereference of some 'struct task_struct * tsk',
linux/task_struct.h is a lightweight alternative.

Thanks again to Niels Kristian Bech Jensen, Andrew Morgan, and Manfred
Spraul.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
--------------1056C6A010D8CFA7C8DA9E0F
Content-Type: application/x-gzip;
 name="k7-smp-inlined2.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="k7-smp-inlined2.patch.gz"

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
2rd2nTu7xs0TNvkfIiQByJ8sAAA=
--------------1056C6A010D8CFA7C8DA9E0F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
