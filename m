Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131511AbRAJAwa>; Tue, 9 Jan 2001 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRAJAwV>; Tue, 9 Jan 2001 19:52:21 -0500
Received: from maila.telia.com ([194.22.194.231]:40196 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S131511AbRAJAwH>;
	Tue, 9 Jan 2001 19:52:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SIGSEGV: Linux 2.4.0 and Konqueror 1.9.8 (from KDE 2.1 Beta 1)
Date: Wed, 10 Jan 2001 01:47:40 +0100
X-Mailer: KMail [version 1.2]
Cc: KDE general mailing list <kde@lists.netcentral.net>
MIME-Version: 1.0
Message-Id: <01011001474000.03448@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Konqueror behaves really strange with the new kernel (compiled with 2.95.2 as 
all my kernels for a very long time)

I have not seen this behaviour (to this extent) with earlier 2.4 kernels.

Included a strace... strange use of brk - or? [included /proc/pid/maps too]
It bugs out like this for other reasons as well. (not zdnet specific)

Note: read on it is not the icon stuff that is strange...

Computer: PPro 180, 96MB RAM
Swap [from dmesg] :
 Adding Swap: 530136k swap-space (priority -1)
 Adding Swap: 133048k swap-space (priority -2)                                
 
Linux version 2.4.0 (root@dox) (gcc version 2.95.2 19991024 (release)) #2 Fri 
Jan 5 23:49:17 CET 2001

access("/opt/kde2/share/apps/konqueror/icons/hicolor/22x22/actions/favicons/www.zdnet.com.xpm", 
R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde2/share/icons/hicolor/22x22/actions/favicons/www.zdnet.com.xpm", 
R_OK) = -1 ENOENT (No such file or directory)
[...]
R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde2/share/icons/locolor/22x22/actions/favicons/www.zdnet.com.xpm", 
R_OK) = -1 ENOENT (No such file or directory)
time([979085700])                       = 979085700
gettimeofday({979085700, 853318}, NULL) = 0
write(7, "\2\1\2\0.\1\0\0\1\0\0\0", 12) = 12
write(7, "\0\0\0\17konqueror-3415\0\0\0\0\vkonqueror"..., 111) = 111
write(7, "\0\0\0\210\0h\0t\0t\0p\0:\0/\0/\0w\0w\0w\0.\0z\0d\0n"..., 191) = 191
gettimeofday({979085700, 857154}, NULL) = 0
gettimeofday({979085700, 857408}, NULL) = 0
gettimeofday({979085700, 858925}, NULL) = 0
write(13, "    ae_50_\0\0\0\3\0\0\0\20\0r\0e\0f\0e\0r\0r\0e"..., 184) = 184
write(13, "   105_43_\0\0\0\10\0h\0t\0t\0p\377\377\377\377\377\377"..., 271) 
= 271
gettimeofday({979085700, 863577}, NULL) = 0
gettimeofday({979085700, 863811}, NULL) = 0
gettimeofday({979085700, 864752}, NULL) = 0
gettimeofday({979085700, 865038}, NULL) = 0
gettimeofday({979085700, 865229}, NULL) = 0
gettimeofday({979085700, 865774}, NULL) = 0
gettimeofday({979085700, 866013}, NULL) = 0
gettimeofday({979085700, 866320}, NULL) = 0
gettimeofday({979085700, 866512}, NULL) = 0
gettimeofday({979085700, 866799}, NULL) = 0
gettimeofday({979085700, 870601}, NULL) = 0
write(3, "F\20\5\0\3\6\0\4\v\2\0\4\0\0\0\0Q\2\20\0J\5\n\0\3\6\0\4"..., 2048) 
= 2048
write(3, "B\20\5\0\2\2\0\4\v\2\0\4\1\0\2\0\1\0\23\0@\0\4\0\2\2\0"..., 500) = 
500ioctl(3, FIONREAD, [256])               = 0
read(3, "\26\0$L\f\2\0\4\f\2\0\4\0\0\0\0\3\0\3\0Q\2\20\0\0\0\0\0"..., 256) = 
256ioctl(3, FIONREAD, [0])                 = 0
ioctl(3, FIONREAD, [0])                 = 0
ioctl(3, FIONREAD, [0])                 = 0
write(3, "=\0\4\0\f\2\0\4\0\0\0\0=\2\20\0005\20\4\0\t\6\0\4&\0\0"..., 268) = 
268write(3, ";\3\5\0\7\2\0\4\0\0\0\0\3\0\3\0\24\0\20\0;\3\5\0\10\2\0"..., 
676) = 676
ioctl(3, FIONREAD, [0])                 = 0
ioctl(3, FIONREAD, [0])                 = 0
gettimeofday({979085700, 876529}, NULL) = 0
select(16, [3 4 6 7 9 10 12 13 14 15], NULL, NULL, {0, 0}) = 2 (in [7 13], 
left {0, 0})
read(13, "     4_ a_", 10)              = 10
read(13, "\0\0\0\0", 4)                 = 4
read(7, "\2\1\0\2.\1\0\0", 8)           = 8
read(7, "\1\0\0\0", 4)                  = 4
read(7, "\0\0\0\17konqueror-3415\0\0\0\0\vkonqueror"..., 302) = 302
brk(0x84f8000)                          = 0x84f8000
brk(0x84fd000)                          = 0x84fd000
brk(0x8502000)                          = 0x8502000
brk(0x8507000)                          = 0x8507000
brk(0x850c000)                          = 0x850c000
brk(0x8511000)                          = 0x8511000
brk(0x8516000)                          = 0x8516000
brk(0x851b000)                          = 0x851b000
brk(0x8520000)                          = 0x8520000
[...]
brk(0xd02d000)                          = 0xd02d000
brk(0xd02f000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
brk(0xd031000)                          = 0xd02f000
--- SIGSEGV (Segmentation fault) ---
--- SIGSEGV (Segmentation fault) ---
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++  

roger@dox:~ > cat /proc/3507/maps
08048000-0804d000 r-xp 00000000 03:45 512886     /opt/kde2/bin/kdeinit
0804d000-0804f000 rw-p 00004000 03:45 512886     /opt/kde2/bin/kdeinit
0804f000-0848c000 rwxp 00000000 00:00 0
40000000-40013000 r-xp 00000000 16:04 73442      /lib/ld-2.1.3.so
40013000-40014000 rw-p 00012000 16:04 73442      /lib/ld-2.1.3.so
40014000-40015000 rw-p 00000000 00:00 0
40015000-40035000 r-xp 00000000 03:45 1121794    
/opt/kde2/lib/libDCOP.so.1.0.0 40035000-40037000 rw-p 0001f000 03:45 1121794  
  /opt/kde2/lib/libDCOP.so.1.0.0 40037000-40063000 r-xp 00000000 03:45 
1121834    /opt/kde2/lib/libkparts.so.1.0.0
40063000-40065000 rw-p 0002b000 03:45 1121834    
/opt/kde2/lib/libkparts.so.1.0.0
40065000-400e1000 r-xp 00000000 03:45 1121818    
/opt/kde2/lib/libkfile.so.3.0.0400e1000-400e7000 rw-p 0007b000 03:45 1121818  
  /opt/kde2/lib/libkfile.so.3.0.0400e7000-4016a000 r-xp 00000000 03:45 
1121840    /opt/kde2/lib/libksycoca.so.3.0.0
4016a000-4016d000 rw-p 00082000 03:45 1121840    
/opt/kde2/lib/libksycoca.so.3.0.0
4016d000-401ed000 r-xp 00000000 03:45 1121824    /opt/kde2/lib/libkio.so.3.0.0
401ed000-401f1000 rw-p 0007f000 03:45 1121824    /opt/kde2/lib/libkio.so.3.0.0
401f1000-403bd000 r-xp 00000000 03:45 1121816    
/opt/kde2/lib/libkdeui.so.3.0.0403bd000-403d5000 rw-p 001cb000 03:45 1121816  
  /opt/kde2/lib/libkdeui.so.3.0.0403d5000-403d6000 rw-p 00000000 00:00 0
403d6000-403d7000 rw-p 00000000 00:00 0
403d7000-403f8000 r-xp 00000000 03:45 1121814    
/opt/kde2/lib/libkdesu.so.1.0.0403f8000-403f9000 rw-p 00020000 03:45 1121814  
  /opt/kde2/lib/libkdesu.so.1.0.0403f9000-4051b000 r-xp 00000000 03:45 
1121812    /opt/kde2/lib/libkdecore.so.3.0.0
4051b000-40522000 rw-p 00121000 03:45 1121812    
/opt/kde2/lib/libkdecore.so.3.0.0
40522000-40524000 rw-p 00000000 00:00 0
40524000-40525000 r--p 00000000 03:47 1169529    
/usr/share/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES
40525000-40526000 r--p 00000000 03:47 1104553    
/usr/share/locale/en_US/LC_MONETARY
40526000-40527000 r--p 00000000 03:47 1104555    
/usr/share/locale/en_US/LC_TIME40527000-40528000 r--p 00000000 03:47 1104554  
  /usr/share/locale/en_US/LC_NUMERIC
40528000-40529000 rw-p 00000000 00:00 0
40529000-4052a000 r-xp 00000000 03:47 32778      /usr/lib/gconv/ISO8859-1.so
4052a000-4052b000 rw-p 00000000 03:47 32778      /usr/lib/gconv/ISO8859-1.so
4052b000-4052c000 rw-p 00000000 00:00 0
4052c000-4052d000 rw-p 00000000 00:00 0
4052d000-4052f000 r-xp 00000000 16:04 73457      /lib/libdl.so.2
4052f000-40531000 rw-p 00001000 16:04 73457      /lib/libdl.so.2
40531000-40998000 r-xp 00000000 03:47 1722204    
/usr/lib/qt-2.2.2/lib/libqt.so.2.2.2
40998000-409c0000 rw-p 00466000 03:47 1722204    
/usr/lib/qt-2.2.2/lib/libqt.so.2.2.2
409c0000-409c5000 rw-p 00000000 00:00 0
409c5000-409e4000 r-xp 00000000 03:47 1039721    /usr/lib/libpng.so.2.1.0
409e4000-409e6000 rw-p 0001e000 03:47 1039721    /usr/lib/libpng.so.2.1.0
409e6000-409f3000 r-xp 00000000 03:47 1039616    /usr/lib/libz.so.1.1.3
409f3000-409f5000 rw-p 0000c000 03:47 1039616    /usr/lib/libz.so.1.1.3
409f5000-409f6000 rw-p 00000000 00:00 0
409f6000-40a14000 r-xp 00000000 03:47 1039824    /usr/lib/libjpeg.so.62.0.0
40a14000-40a15000 rw-p 0001d000 03:47 1039824    /usr/lib/libjpeg.so.62.0.0
40a15000-40a22000 r-xp 00000000 03:47 779717     /usr/X11R6/lib/libXext.so.6.4
40a22000-40a23000 rw-p 0000c000 03:47 779717     /usr/X11R6/lib/libXext.so.6.4
40a23000-40aed000 r-xp 00000000 03:47 779557     /usr/X11R6/lib/libX11.so.6.1
40aed000-40af2000 rw-p 000c9000 03:47 779557     /usr/X11R6/lib/libX11.so.6.1
40af2000-40af3000 rw-p 00000000 00:00 0
40af3000-40afb000 r-xp 00000000 03:47 779554     /usr/X11R6/lib/libSM.so.6.0
40afb000-40afd000 rw-p 00007000 03:47 779554     /usr/X11R6/lib/libSM.so.6.0
40afd000-40b12000 r-xp 00000000 03:47 779550     /usr/X11R6/lib/libICE.so.6.3
40b12000-40b13000 rw-p 00014000 03:47 779550     /usr/X11R6/lib/libICE.so.6.3
40b13000-40b15000 rw-p 00000000 00:00 0
40b15000-40b4f000 r-xp 00000000 03:47 1039804    
/usr/lib/libstdc++-3-libc6.1-2-2.10.0.so
40b4f000-40b5b000 rw-p 00039000 03:47 1039804    
/usr/lib/libstdc++-3-libc6.1-2-2.10.0.so
40b5b000-40b5d000 rw-p 00000000 00:00 0
40b5d000-40b5e000 rw-p 00000000 00:00 0
40b5e000-40b60000 r-xp 00000000 16:04 73467      /lib/libutil.so.1
40b60000-40b61000 rw-p 00001000 16:04 73467      /lib/libutil.so.1
40b61000-40b7d000 r-xp 00000000 16:04 73458      /lib/libm.so.6
40b7d000-40b7e000 rw-p 0001b000 16:04 73458      /lib/libm.so.6
40b7e000-40c59000 r-xp 00000000 16:04 73453      /lib/libc.so.6
40c59000-40c5e000 rw-p 000da000 16:04 73453      /lib/libc.so.6
40c5e000-40c61000 rw-p 00000000 00:00 0
40c61000-40c9e000 r-xp 00000000 03:47 1039886    /usr/lib/libmng.so.0.0.9
40c9e000-40ca0000 rw-p 0003c000 03:47 1039886    /usr/lib/libmng.so.0.0.9
40ca0000-40cac000 r-xp 00000000 03:47 1039856    /usr/lib/liblcms.so.1.0.6
40cac000-40cae000 rw-p 0000b000 03:47 1039856    /usr/lib/liblcms.so.1.0.6
40cae000-40cb0000 rw-p 00000000 00:00 0
40cb0000-40cb1000 rw-p 00000000 00:00 0
40cb1000-40d2a000 r-xp 00000000 03:45 1121492    /opt/kde2/lib/konqueror.so
40d2a000-40d2e000 rw-p 00078000 03:45 1121492    /opt/kde2/lib/konqueror.so
40d2e000-40d2f000 rw-p 00000000 00:00 0
40d2f000-40da8000 r-xp 00000000 03:45 1121599    
/opt/kde2/lib/libkonq.so.3.0.0
40da8000-40dac000 rw-p 00078000 03:45 1121599    
/opt/kde2/lib/libkonq.so.3.0.0
40dac000-40db4000 r--p 00000000 03:47 1104551    
/usr/share/locale/en_US/LC_COLLATE
40db4000-40dca000 r--p 00000000 03:47 1104552    
/usr/share/locale/en_US/LC_CTYPE
40dca000-40e18000 r--s 00000000 16:04 171506     /tmp/kde-roger/ksycoca
40e18000-40fbd000 r-xp 00000000 03:45 1121820    
/opt/kde2/lib/libkhtml.so.3.0.040fbd000-40fdf000 rw-p 001a4000 03:45 1121820  
  /opt/kde2/lib/libkhtml.so.3.0.040fdf000-40fe1000 rw-p 00000000 00:00 0
40fe1000-40ffe000 r-xp 00000000 03:45 1121826    
/opt/kde2/lib/libkjava.so.1.0.040ffe000-41000000 rw-p 0001c000 03:45 1121826  
  /opt/kde2/lib/libkjava.so.1.0.041000000-410c0000 r-xp 00000000 03:45 
1121838    /opt/kde2/lib/libkssl.so.2.0.0
410c0000-410c6000 rw-p 000bf000 03:45 1121838    
/opt/kde2/lib/libkssl.so.2.0.0
410c6000-410c9000 rw-p 00000000 00:00 0
410c9000-410ca000 rw-p 00000000 00:00 0
410ca000-410cb000 rw-p 00000000 00:00 0
410cb000-410cc000 rw-p 00000000 00:00 0
bffec000-c0000000 rwxp fffed000 00:00 0  
/RogerL

     
-- 
--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
