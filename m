Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269833AbUJMUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbUJMUhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJMUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:37:47 -0400
Received: from smtp17.wxs.nl ([195.121.6.13]:43233 "EHLO smtp17.wxs.nl")
	by vger.kernel.org with ESMTP id S269833AbUJMUhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:37:36 -0400
Date: Wed, 13 Oct 2004 22:38:19 +0200
From: Stef van der Made <svdmade@planet.nl>
Subject: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
In-reply-to: <416D8C33.9080401@osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <416D923B.3030404@planet.nl>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041011
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
 <416D8999.7080102@pobox.com> <Pine.LNX.4.58.0410131302190.31327@danga.com>
 <416D8C33.9080401@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to get kernel-2.6.9-rc4-mm1 to work with gnome-2.8. While 
2.6.9-rc4 works fine with gnome-2.8 the mm1 version has an issue. Any 
process that I'm trying to start that uses gnome libraries crashes 
immediatly after startup. Mozilla, nautilus and gnome terminal to name a 
few. The reason for using mm1 is that I'm using reiser4 for one of my 
partitions.

The output that I get in bugbuddy is as following:

Backtrace was generated from '/usr/test/garnome2/lib/nautilus'

0x40d164ba in ?? ()
#0  0x40d164ba in ?? ()
#1  0x402b4860 in ?? ()
#2  0x40d14bc5 in ?? ()
#3  <signal handler called>
#4  0x40f33281 in ?? ()
#5  0x40f33347 in ?? ()
#6  0x40d11238 in ?? ()
#7  0x40d0dd28 in ?? ()
#8  0x40c6b19d in ?? ()
#9  0x40c6e3b9 in ?? ()
#10 0x40c6e5b1 in ?? ()
#11 0x40c7f4f2 in ?? ()
#12 0x40c3d10e in ?? ()
#13 0x40c42fe2 in ?? ()
#14 0x40c3e1ee in ?? ()
#15 0x40c40cbf in ?? ()
#16 0x40c40db4 in ?? ()
#17 0x40c42f90 in ?? ()
#18 0x40c3f2af in ?? ()
#19 0x40c3f59b in ?? ()
#20 0x4087127e in ?? ()
#21 0x408713fb in ?? ()
#22 0x408934e2 in ?? ()
#23 0x40cc373b in ?? ()
#24 0x40caa513 in ?? ()
#25 0x40caa8d1 in ?? ()
#26 0x40caa9f6 in ?? ()
#27 0x40893f4e in ?? ()
#28 0x40893fa6 in ?? ()
#29 0x80694ef in ?? ()
#30 0x40cc3fe5 in ?? ()
#31 0x40caaa22 in ?? ()
#32 0x408f9f57 in ?? ()
#33 0x40ca9cb0 in ?? ()
#34 0x40caa8d1 in ?? ()
#35 0x40caa9f6 in ?? ()
#36 0x8069600 in ?? ()
#37 0x8077205 in ?? ()
#38 0x40f1f916 in ?? ()

And on the terminal that I started X windows:

"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
/home/stef/405: No such file or directory.
/usr/local/mozilla/run-mozilla.sh: line 423:   460 Segmentation 
fault      "$prog" ${1+"$@"}
"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
/home/stef/448: No such file or directory.
"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
/home/stef/448: No such file or directory.
ptrace: No such process.
/usr/test/garnome2/share/bug-buddy/gdb-cmd:1: Error in sourced command file:
No stack.
"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
/home/stef/448: No such file or directory.
ptrace: No such process.
/usr/test/garnome2/share/bug-buddy/gdb-cmd:1: Error in sourced command file:
No stack.
/usr/local/mozilla/run-mozilla.sh: line 423:   483 Segmentation 
fault      "$prog" ${1+"$@"}

ldd for nautilus

bash-2.05b$ ldd /usr/test/garnome2/bin/nautilus
        libnautilus.so.2 => /usr/test/garnome2/lib/libnautilus.so.2 
(0x40016000)
        libnautilus-adapter.so.2 => 
/usr/test/garnome2/lib/libnautilus-adapter.so.2 (0x40028000)
        libnautilus-private.so.2 => 
/usr/test/garnome2/lib/libnautilus-private.so.2 (0x4002b000)
        libnautilus-extension.so.1 => 
/usr/test/garnome2/lib/libnautilus-extension.so.1 (0x400d5000)
        libeel-2.so.2 => /usr/test/garnome2/lib/libeel-2.so.2 (0x400de000)
        libXrender.so.1 => /usr/local/lib/libXrender.so.1 (0x4017f000)
        libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0x40187000)
        libgailutil.so.17 => /usr/test/garnome2/lib/libgailutil.so.17 
(0x40195000)
        libglade-2.0.so.0 => /usr/test/garnome2/lib/libglade-2.0.so.0 
(0x4019d000)
        librsvg-2.so.2 => /usr/test/garnome2/lib/librsvg-2.so.2 (0x401b4000)
        libgsf-1.so.1 => /usr/test/garnome2/lib/libgsf-1.so.1 (0x401e0000)
        libbz2.so.1.0 => /lib/libbz2.so.1.0 (0x40201000)
        libcroco-0.6.so.3 => /usr/test/garnome2/lib/libcroco-0.6.so.3 
(0x40211000)
        libgnome-desktop-2.so.2 => 
/usr/test/garnome2/lib/libgnome-desktop-2.so.2 (0x4024b000)
        libgnomeui-2.so.0 => /usr/test/garnome2/lib/libgnomeui-2.so.0 
(0x40260000)
        libgnome-keyring.so.0 => 
/usr/test/garnome2/lib/libgnome-keyring.so.0 (0x402f1000)
        libbonoboui-2.so.0 => /usr/test/garnome2/lib/libbonoboui-2.so.0 
(0x402fc000)
        libgnomecanvas-2.so.0 => 
/usr/test/garnome2/lib/libgnomecanvas-2.so.0 (0x4035c000)
        libgnome-2.so.0 => /usr/test/garnome2/lib/libgnome-2.so.0 
(0x40388000)
        libesd.so.0 => /usr/test/garnome2/lib/libesd.so.0 (0x4039b000)
        libasound.so.2 => /usr/lib/libasound.so.2 (0x403a4000)
        libaudiofile.so.0 => /usr/test/garnome2/lib/libaudiofile.so.0 
(0x4044e000)
        libart_lgpl_2.so.2 => /usr/test/garnome2/lib/libart_lgpl_2.so.2 
(0x40473000)
        libpangoft2-1.0.so.0 => 
/usr/test/garnome2/lib/libpangoft2-1.0.so.0 (0x40488000)
        libgtk-x11-2.0.so.0 => 
/usr/test/garnome2/lib/libgtk-x11-2.0.so.0 (0x404ad000)
        libgdk-x11-2.0.so.0 => 
/usr/test/garnome2/lib/libgdk-x11-2.0.so.0 (0x40770000)
        libatk-1.0.so.0 => /usr/test/garnome2/lib/libatk-1.0.so.0 
(0x407dd000)
        libgdk_pixbuf-2.0.so.0 => 
/usr/test/garnome2/lib/libgdk_pixbuf-2.0.so.0 (0x407f8000)
        libpangoxft-1.0.so.0 => 
/usr/test/garnome2/lib/libpangoxft-1.0.so.0 (0x4080e000)
        libpangox-1.0.so.0 => /usr/test/garnome2/lib/libpangox-1.0.so.0 
(0x40813000)
        libpango-1.0.so.0 => /usr/test/garnome2/lib/libpango-1.0.so.0 
(0x4081d000)
        libgnomevfs-2.so.0 => /usr/test/garnome2/lib/libgnomevfs-2.so.0 
(0x4084b000)
        libgconf-2.so.4 => /usr/test/garnome2/lib/libgconf-2.so.4 
(0x408ac000)
        libbonobo-2.so.0 => /usr/test/garnome2/lib/libbonobo-2.so.0 
(0x408d5000)
        libxml2.so.2 => /usr/test/garnome2/lib/libxml2.so.2 (0x4092f000)
        libssl.so.0 => /usr/lib/libssl.so.0 (0x40a34000)
        libhowl-0.9.6.so.1 => /usr/test/garnome2/lib/libhowl-0.9.6.so.1 
(0x40aea000)
        libresolv.so.2 => /lib/libresolv.so.2 (0x40c10000)
        librt.so.1 => /lib/librt.so.1 (0x40c22000)
        libbonobo-activation.so.4 => 
/usr/test/garnome2/lib/libbonobo-activation.so.4 (0x40c34000)
        libORBitCosNaming-2.so.0 => 
/usr/test/garnome2/lib/libORBitCosNaming-2.so.0 (0x40c4a000)
        libORBit-2.so.0 => /usr/test/garnome2/lib/libORBit-2.so.0 
(0x40c4f000)
        libgobject-2.0.so.0 => 
/usr/test/garnome2/lib/libgobject-2.0.so.0 (0x40c9d000)
        libm.so.6 => /lib/libm.so.6 (0x40cda000)
        libgmodule-2.0.so.0 => 
/usr/test/garnome2/lib/libgmodule-2.0.so.0 (0x40cfc000)
        libdl.so.2 => /lib/libdl.so.2 (0x40d00000)
        libgthread-2.0.so.0 => 
/usr/test/garnome2/lib/libgthread-2.0.so.0 (0x40d04000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x40d09000)
        libglib-2.0.so.0 => /usr/test/garnome2/lib/libglib-2.0.so.0 
(0x40d5a000)
        libstartup-notification-1.so.0 => 
/usr/test/garnome2/lib/libstartup-notification-1.so.0 (0x40dd8000)
        libSM.so.6 => /usr/X11R6/lib/libSM.so.6 (0x40de0000)
        libICE.so.6 => /usr/X11R6/lib/libICE.so.6 (0x40de9000)
        libcdda_paranoia.so.0 => /usr/local/lib/libcdda_paranoia.so.0 
(0x40e02000)
        libcdda_interface.so.0 => /usr/local/lib/libcdda_interface.so.0 
(0x40e0a000)
        libjpeg.so.62 => /usr/lib/libjpeg.so.62 (0x40e1c000)
        libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x40e3b000)
        libpopt.so.0 => /usr/lib/libpopt.so.0 (0x40f04000)
        libc.so.6 => /lib/libc.so.6 (0x40f0a000)
        libz.so.1 => /usr/lib/libz.so.1 (0x4103a000)
        libfontconfig.so.1 => /usr/local/lib/libfontconfig.so.1 (0x4104a000)
        libfreetype.so.6 => /usr/local/lib/libfreetype.so.6 (0x41071000)
        libXrandr.so.2 => /usr/X11R6/lib/libXrandr.so.2 (0x410dd000)
        libXi.so.6 => /usr/X11R6/lib/libXi.so.6 (0x410e1000)
        libXinerama.so.1 => /usr/X11R6/lib/libXinerama.so.1 (0x410e9000)
        libXft.so.2 => /usr/local/lib/libXft.so.2 (0x410ec000)
        libXcursor.so.1 => /usr/local/lib/libXcursor.so.1 (0x410ff000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
        libexpat.so.0 => /usr/local/lib/libexpat.so.0 (0x41108000)
        libgcc_s.so.1 => /usr/local/lib/libgcc_s.so.1 (0x41127000)

I've compiled the kernel from source on a slackware-8.0 box. My compiler 
is gcc-3.4.2 using glibc-2.3.2. Gnome has been compiled using the 
garnome system version 2.8.0.

The information provided is probably not nearly enough to solve or find 
the issue so a little help would be greatly appriciated.

Best regards,

Stef
