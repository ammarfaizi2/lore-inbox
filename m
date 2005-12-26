Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVLZSCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVLZSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLZSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:02:25 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:53906 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbVLZSCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:02:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkzQF48QpYRZ3mgVCppJWiKdv/1RojtMaBB0/zac3K6tDpHqsy9xx4jFeflNwkzkwJOrI0zCiz2q0uyhHDfQGNChwjd4uR8/YZWmL9JgrIwuM9tOopuCtcqjljT15I5/dBANwu8XVPKDdTK5k7veXI+G1M9Cng0azCrHjQLqTLU=
Message-ID: <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
Date: Mon, 26 Dec 2005 10:02:23 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Please do give it a try, and if you have any issues/regressions, send out
> a note (even if you sent one earlier) so that we don't forget about it.
>
> Thanks,
>
>                 Linus

Hi Linus,
   I've visiting at my parents house and gave 2.6.15-rc7 a try on my
dad's machine. This machine is his normal desktop box which I
administer remotely, as well as a MythTV server. The new kernel built
and booted fine. I then built the NVidia stuff. However when I tried
to build the ivtv driver from portage it failed:

 * Determining the location of the kernel source code
 * Found kernel source directory:
 *     /usr/src/linux
 * Found sources for kernel version:
 *     2.6.15-rc7
 * Checking for suitable kernel configuration options:
>>> Unpacking source...
>>> Unpacking ivtv-0.4.0.tar.gz to /var/tmp/portage/ivtv-0.4.0-r2/work
>>> Unpacking pvr_2.0.24.23035.zip to /var/tmp/portage/ivtv-0.4.0-r2/work
>>> Source unpacked.
 * Preparing ivtv module
created ivtv-svnversion.h
make CONFIG_VIDEO_IVTV=m -C /usr/src/linux
M=/var/tmp/portage/ivtv-0.4.0-r2/work /ivtv-0.4.0/driver modules
make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
  CC [M]  /var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3400.o
In file included from
/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/comp at.h:77,
                 from
/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3 400.c:52:
include/linux/videodev.h: In function `video_device_create_file':
include/linux/videodev.h:21: error: dereferencing pointer to incomplete type
include/linux/videodev.h: In function `video_device_remove_file':
include/linux/videodev.h:27: error: dereferencing pointer to incomplete type
In file included from
/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/comp at.h:77,
                 from
/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3 400.c:52:
include/linux/videodev.h:30:5: warning: "OBSOLETE_OWNER" is not defined
include/linux/videodev.h: At top level:
include/linux/videodev.h:204: error: `VIDEO_MAX_FRAME' undeclared here
(not in a  function)
make[2]: *** [/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3400.o]
E rror 1
make[1]: *** [_module_/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver]
Err or 2
make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
make: *** [all] Error 2

!!! ERROR: media-tv/ivtv-0.4.0-r2 failed.
!!! Function linux-mod_src_compile, Line 505, Exitcode 2
!!! Unable to make                                  KDIR=/usr/src/linux all.
!!! If you need support, post the topmost build error, NOT this status message.

gandalf src #

   Most probably this is stuff the Gentoo devs will clean up when the
real kernel comes out but I *think* you were asking for this sort of
info so I'm posting it back.

Cheers to all,
Mark
