Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130697AbQK1FCc>; Tue, 28 Nov 2000 00:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130749AbQK1FCW>; Tue, 28 Nov 2000 00:02:22 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:53253 "EHLO
        uberbox.mesatop.com") by vger.kernel.org with ESMTP
        id <S130697AbQK1FCP>; Tue, 28 Nov 2000 00:02:15 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
Date: Mon, 27 Nov 2000 21:32:40 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112721324000.01098@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
>> For what its worth, on my single processor home machine, all kernels
>> 2.4.0-test11-ac1,ac2,ac3, ac4 both UP and SMP run both Gnome and
>> KDE 2.0, with reiserfs-3.6.19.  In other words, everything works with
>> everything.
>
>Nod. It actually puzzles me since from the kernel view I doubt kde and gnome
>even look different at the syscall level. They may look different to X but
>X isnt the thing that changed

Agreed.  I suspect that this could be a rough spot with reiserfs-3.6.19.
I observed one similar freezup while doing
tar zxvf linux-2.4.0-test11.tar.gz 
while running 2.4.0-test11-pre7, patched with reiserfs-3.6.19.

I and others have experienced some off-normal behaviour with 
reiserfs, like crashing when saving a file on top of itself with StarOffice
5.2 when the file was on an NFS server.  That particular bug
was fixed in reiserfs-3.6.14, IIRC.  But even with the few rough edges, 
reiserfs has become essential to our operations, with its ability to recover
so quickly after a UPS has caused problems.  That's why I'm following the
2.4.0 development so closely with reiserfs.

I was never able to reproduce the tar freeze.  The freeze which I
observed with test11-ac2,4 SMP and KDE 2.0 was very reproducable; I saw
it at least 6 times, always in exactly the same place of the startup of
KDE 2.0.

Tomorrow when I have access to the two-way P-III problem machine,
I'll repatch 2.4.0-test11-ac4 with reiserfs-3.6.18,
which is a little less bleeding edge than reiserfs-3.6.19.

Meanwhile, 2.4.0-test12-pre2 patched with reiserfs-3.6.19 is running
nicely with KDE 2.0 on the uniprocessor home machine.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
