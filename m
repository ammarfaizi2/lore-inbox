Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbQLFXpu>; Wed, 6 Dec 2000 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbQLFXpk>; Wed, 6 Dec 2000 18:45:40 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:47118 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131443AbQLFXpd>;
	Wed, 6 Dec 2000 18:45:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mike Kravetz <mkravetz@sequent.com>
Date: Thu, 7 Dec 2000 00:14:34 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: test12pre6: BUG in schedule (sched.c, 115)
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <EEECBF36EBE@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Dec 00 at 14:00, Mike Kravetz wrote:
> 
> Are you sure that was line 115?  Could it have been line 515?
> Also, do you have any Oops data?
> 

Yesterday BUG in schedule at 515 happened for me with test12-pre4.
As there were no data, and it was followed by

NMI detected lockup on CPU24 ...

(without any further data... no stack trace), I throwed it away as 
some -pre4 memory corruption. Maybe it was not random corruption, but
stack overflow? Of course, my machine does not have 25 CPUs, but only 
two PIII...

And no, I have no oops data. I was reviewing Debian changes
(apt-listchanges) when picture scrolled up one line (bug in sched) and
then, after 5 seconds, another one line, with 'NMI detected'... And
that was all, time to hit reset.

It was very patched test12-pre4, it contained Al Viro & Sct dirty buffer
patches, Andrew Morton's exec_usermodehelper, and couple of other
patches, brutto 153KB unzipped unified diff.

Filesystem ext2, 256MB RAM, dual PIII/450, kernel compiled with Debian's
gcc-2.95.2, matroxfb. On background there were Debian's XF4.0.1-9
running with Gnome and DRI, as I was tracking why that beast reprograms
matrox hardware every second (or every minute, depending on format of
clock in left upper corner; but that's another story) even if X are not
visible... (btw that's reason, why matroxfb does not work correctly with
XF4 & DRI...)
                                Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
