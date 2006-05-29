Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWE2SJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWE2SJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWE2SJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:09:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:42279 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751158AbWE2SJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:09:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HWLPZRDE6L8RiRkiD11mwjpGrlaH8cKOUnJZ8QN+7qBvbyEnIYqglRRqM+i5pSW5qV0vp0B9FplXMp37DVhLimENPIFxMJ92PByiT7g2IDG/VKAKdHprW3S0L3wxbNaOSYkrLWvtR7pH0volESpLavUN9p4U/2ng5cwiUB6tYr0=
Message-ID: <6bffcb0e0605291109s92ade61k4d4a96cd99e7ccf0@mail.gmail.com>
Date: Mon, 29 May 2006 20:09:39 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: 2.6.17-rc4-mm3-lockdep compilation error
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

lockdep-serial.patch is causing this error
/usr/src/linux-work/drivers/serial/serial_core.c:621:16: warning: incorrect type
 in assignment (different base types)
/usr/src/linux-work/drivers/serial/serial_core.c:621:16:    expected int [signed
] [addressable] [assigned] flags
/usr/src/linux-work/drivers/serial/serial_core.c:621:16:    got
restricted unsig                                            ned int
[usertype] flags
/usr/src/linux-work/drivers/serial/serial_core.c:686:12: warning:
incorrect type                                             in
assignment (different base types)
/usr/src/linux-work/drivers/serial/serial_core.c:686:12:    expected
restricted                                             unsigned int
[usertype] new_flags
/usr/src/linux-work/drivers/serial/serial_core.c:686:12:    got int
[signed] [ad                                            dressable]
[assigned] flags
/usr/src/linux-work/drivers/serial/serial_core.c:2264:3: error:
undefined identi                                            fier
'port_lock_key'
/usr/src/linux-work/drivers/serial/serial_core.c: In function
'uart_add_one_port                                            ':
/usr/src/linux-work/drivers/serial/serial_core.c:2264: error:
'port_lock_key' un                                            declared
(first use in this function)
/usr/src/linux-work/drivers/serial/serial_core.c:2264: error: (Each
undeclared i                                            dentifier is
reported only once
/usr/src/linux-work/drivers/serial/serial_core.c:2264: error: for each
function                                             it appears in.)
make[3]: *** [drivers/serial/serial_core.o] Error 1
make[2]: *** [drivers/serial] Error 2
make[1]: *** [drivers] Error 2
make: *** [_all] Error 2

gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--enable-checking=release --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=c,c++,objc,obj-c++,java,fortran,ada
--enable-java-awt=gtk --disable-dssi
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--with-cpu=generic --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
