Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRCMGeB>; Tue, 13 Mar 2001 01:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130921AbRCMGdw>; Tue, 13 Mar 2001 01:33:52 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:16394 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S130920AbRCMGdm>; Tue, 13 Mar 2001 01:33:42 -0500
Date: Tue, 13 Mar 2001 03:35:26 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ln -l says symlink has size 281474976710666
Message-ID: <20010313033526.A633@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as the subject says:

  lrwxrwxrwx    1 root     root     281474976710666 Jan 27 20:50 imlib1 -> imlib-base

it isn't the only one, for example

  lrwxrwxrwx    1 root     root     281474976710669 Jan 27 14:43 fd -> /proc/self/fd

i.e. 2**48 + what it should be.

ver_linux says

  Gnu C                  2.95.3
  Gnu make               3.79.1
  binutils               2.10.91.0.2
  util-linux             2.10s
  modutils               2.4.2
  e2fsprogs              1.19
  reiserfsprogs          3.x.0b
  PPP                    2.4.0
  Linux C Library        2.2.2
  Dynamic linker (ldd)   2.2.2
  Procps                 2.0.7
  Net-tools              1.58
  Kbd                    1.04
  Sh-utils               2.0.11
  Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc rtc

the fs is plain ext2, and I'm running 2.4.2-ac16. My first guess
was I was needing a newer foo, but all my foos seem to be OK
(except for reiserfsprogs, but that's another issue).

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
L'acne giovanile si cura con la vecchiaia.
