Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129774AbQK1Rn3>; Tue, 28 Nov 2000 12:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129520AbQK1RnT>; Tue, 28 Nov 2000 12:43:19 -0500
Received: from gl177a.Glassen.BoNet.AC ([212.217.128.37]:64784 "HELO
        findus.dhs.org") by vger.kernel.org with SMTP id <S129774AbQK1RnE>;
        Tue, 28 Nov 2000 12:43:04 -0500
Message-ID: <3A23E790.D0F3B8B7@findus.dhs.org>
Date: Tue, 28 Nov 2000 18:12:48 +0100
From: Petter Sundlöf <odd@findus.dhs.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I am unsure to whom this bug should be sent, so I'll send it here.

The problem manifests itself when I QUIT XFree86 (4.0.1, regular .1
release and CVS). What happens is that when I have quit X one or two
times, I start getting segfaults on practically everything (sometimes it
won't even catch CTRL+ALT+DELETE).
The above happens on -test7 and other test kernels (I believe I have
tried -test8, 9 and 10, but I am unsure), and another problem that has
only happened exclusively when using 2.4.0-test11 is that I have lost
TERMINFO and such (like when trying to run the editor "joe") beside the
segfaults.
I get the segfaults on -test11 as well, of course. This I also get on
both that I have tried: When I log out and try to log in again it says
"INIT: Id "cX" respawning too fast: disabled for 5 minutes."

The above does not happen with kernel 2.2.16, 2.2.17.

My graphics card is a NVIDIA GeForce DDR, using the 0.9-5 release. For
-test11 I had to patch 0.9-5 (but this was only a very trivial patch, I
am told).

Observer that this only happens after I have quit X. Meanwhile X is
running I can compile much stuff simultaneously with a proble, re-login
again and again and so on and so forth. This of course also the case
before I have started X.

I have been told that there is no AGP driver in the 2.2.x kernel, and
that this might be a part of the problem? This is my hardware:

Motherboard with VIA KX133 chipset
Athlon K7 600
256 MB PC133 memory (256 MB swap)
NVIDIA GeForce DDR
Adaptec 2940 U2W/LVD
<Unknown> 18 GB LVD driver

My system software:

Slackware-current from a week or so ago.
 Here is what ver_linux reports on 2.4.0-test11:

 $ ./ver_linux 
 -- Versions installed: (if some fields are empty or looks
 -- unusual then possibly you have very old versions)
 Linux celibacy 2.4.0-test11 #1 Wed Nov 22 14:46:05 CET 2000 i686
unknown
 Kernel modules         2.3.18
 Gnu C                  egcs-2.91.66
 Binutils               2.10.0.24
 Linux C Library        ..
 Dynamic Linker (ld.so) 1.9.9
 ls: /usr/lib/libg++.so: No such file or directory
 Procps                 2.0.7
 Mount                  2.10q
 Net-tools              (2000-05-21)
 Kbd                    0.99
 Sh-utils               2.0
 Sh-utils               Parker.
 Sh-utils               
 Sh-utils               Inc.
 Sh-utils               NO
 Sh-utils               PURPOSE.

I hope this report is sufficient... if not, please let me know what is
lacking in it.

Best wishes, Petter Sundlöf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
