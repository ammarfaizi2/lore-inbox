Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131355AbRAPByO>; Mon, 15 Jan 2001 20:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRAPByD>; Mon, 15 Jan 2001 20:54:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41477 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131355AbRAPBx4>;
	Mon, 15 Jan 2001 20:53:56 -0500
Message-ID: <3A63A9AE.345CBAF3@mandrakesoft.com>
Date: Mon, 15 Jan 2001 20:53:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pre5 VM feedback..
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$!@#@! pre6 is already out :)

Anyway, this may be a totally subjective (and incorrect) perception, but
it seems to me like the recent 2.4.x-test kernels and thereafter start
swapping things out really quickly.  Case in point:  "diff -urN
linux.vanilla linux" command swaps out Konqueror and Netscape Mail, even
though I was using them only a few minutes ago.  Since hacking involves
a lot of "run this command, then do something else until it finishes" :)
my perception of the recent 2.4.x kernels is that my X apps are always
getting swapped out just because a big diff or make was the only active
process for ~5 minutes.

Anyway, the hard data.  The following is VM measurements taken during a
diff of two kernel trees (2.4.1-pre4 and pre5, in fact):

before diff
-----------
ps aux: http://gtf.org/garzik/vm1/before.ps.txt
meminfo: http://gtf.org/garzik/vm1/before.meminfo.txt

after diff
----------
ps aux: http://gtf.org/garzik/vm1/after.ps.txt
meminfo: http://gtf.org/garzik/vm1/after.meminfo.txt

"vmstat 3" was running in the background during the diff.  The following
is the output from that.  It should be noted that the final burst of
swapping came from my switching X desktops, forcing Netscape and
Konqueror to swap in.
http://gtf.org/garzik/vm1/vmstat.log

Obligatory dmesg output, which includes hardware info.  Summary: Dual
P-II w/ 128MB RAM
http://gtf.org/garzik/vm1/after.dmesg.txt

FWIW I am not attempting to imply that any particular conclusion should
be drawn from this data.  I just thought that the VM folks might find it
interesting and/or useful.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
