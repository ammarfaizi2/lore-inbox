Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318737AbSG0LhZ>; Sat, 27 Jul 2002 07:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSG0LhZ>; Sat, 27 Jul 2002 07:37:25 -0400
Received: from t5o913p16.telia.com ([212.181.179.16]:27011 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S318737AbSG0LhY>;
	Sat, 27 Jul 2002 07:37:24 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, ldm@flatcap.org
Subject: Re: Linux v2.5.29
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 27 Jul 2002 13:40:28 +0200
In-Reply-To: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
Message-ID: <m28z3x761f.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> <ldm@flatcap.org>:
>   o New LDM Driver (Windows Dynamic Disks)

Breaks "make xconfig". Here is a patch to fix it:

--- linux/fs/partitions/Config.in.orig	Sat Jul 27 13:31:54 2002
+++ linux/fs/partitions/Config.in	Sat Jul 27 13:16:15 2002
@@ -25,7 +25,7 @@
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
    fi
-   dep_bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION
+   bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION
    if [ "$CONFIG_LDM_PARTITION" = "y" ]; then
       bool '    Windows LDM extra logging' CONFIG_LDM_DEBUG
    fi

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
