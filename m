Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGGO65>; Sat, 7 Jul 2001 10:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266429AbRGGO6r>; Sat, 7 Jul 2001 10:58:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36040 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266400AbRGGO6h>;
	Sat, 7 Jul 2001 10:58:37 -0400
Message-ID: <3B47239B.69E72F18@mandrakesoft.com>
Date: Sat, 07 Jul 2001 10:58:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Filesystem bug?  "sync" hangs...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.7-pre3 on alpha.

The initial phase of an RPM build is unpacking a tarball and applying
patches, which is a bunch of writes followed by a update of read/write
updates.  A lot of write activity, basically.  RPM build is running at
normal priority as a normal user.

In another xterm, su'd in a shell that is renice'd to -14, I run "sync"
during all this write activity.  It hangs for 17 seconds before I get
impatient, stop counting, and suspend the RPM build process.  sync
continues to block, not returning to the command prompt.  I run dmesg
(generated read activity?), and sync finally returns.

The RPM build process continues unpacking/writing files without
appearing to slow in window 1 while sync blocks in window 2.

I have not seen this behavior before, but I do not recall trying 'sync'
specifically during heavy write activity before.  This behavior is
reproducible.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
