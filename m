Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbQLWIJR>; Sat, 23 Dec 2000 03:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130379AbQLWIJH>; Sat, 23 Dec 2000 03:09:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:11017 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130308AbQLWIIw>;
	Sat, 23 Dec 2000 03:08:52 -0500
Mail-Copies-To: never
To: Damacus Porteng <kernel@bastion.yi.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arg.  File > 2GB removal
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>
From: Andreas Jaeger <aj@suse.de>
Date: 23 Dec 2000 08:27:11 +0100
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>
Message-ID: <u8lmt71ttc.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Damacus Porteng writes:

 > For grins, I did `dd if=/dev/zero of=testfile bs=1024 count=4000000` 
 > Obviously, with the limits of ext2, this isn't allowed, however, dd continued
 > marrily on its way, tho it spouted an error...
With 2.4 it's allowed.

 > I cancelled the dd and went to remove the file, though the following occured:
 > root@obfuscated:/home/ftp# rm testfile
 > rm: cannot remove `testfile': Value too large for defined data type     

 > 'ls' complains about the same.  I ran e2fsck -f /dev/hde6 (the partition of
 > /home) and it didn't 'find' the problem.
You need an rm that's using the LFS interface.

 > How do I remove this file and reclaim the HDD space?
Try:
echo > testfile

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
