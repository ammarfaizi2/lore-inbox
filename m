Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273626AbRIYVLE>; Tue, 25 Sep 2001 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273635AbRIYVKy>; Tue, 25 Sep 2001 17:10:54 -0400
Received: from zape.um.es ([155.54.0.102]:8155 "EHLO zape.um.es")
	by vger.kernel.org with ESMTP id <S273626AbRIYVKt>;
	Tue, 25 Sep 2001 17:10:49 -0400
Message-ID: <3BB0F483.69929A79@ditec.um.es>
Date: Tue, 25 Sep 2001 23:17:55 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.77 [es] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Bad, bad, bad VM behaviour in 2.4.10
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My test is very simple. I have started X-Window and XMMS in order to
listen to some songs. Then, I have executed

	dd if=/dev/hdc1 of=/dev/null

as root within a terminal, and I have got the following a few seconds
later:

Sep 25 22:05:55 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:00 localhost last message repeated 2 times
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:00 localhost last message repeated 2 times
Sep 25 22:06:00 localhost kernel: VM: killing process xmms
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 11 times
Sep 25 22:06:04 localhost kernel: VM: killing process xmms
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost kernel: VM: killing process kmix
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 2 times
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 3 times
Sep 25 22:06:04 localhost kernel: VM: killing process gpm
Sep 25 22:06:05 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:06 localhost last message repeated 6 times
sep 25 22:06:06 localhost su(pam_unix)[2548]: session closed for user
root
Sep 25 22:06:06 localhost kernel: VM: killing process sendmail
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process konsole
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process named
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process xmms
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost last message repeated 3 times
Sep 25 22:06:07 localhost kernel: VM: killing process ksmserver
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process kdeinit
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: VM: killing process X
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
f60
Sep 25 22:06:08 localhost last message repeated 2 times
Sep 25 22:06:08 localhost kernel: VM: killing process kdeinit
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: VM: killing process startkde
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:09 localhost kernel: VM: killing process named
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60

The /dev/hdc1 partition capacity is 6 GB. My root partition is on
/dev/hda5. My computer is a Pentium III with 384 MB of RAM.

BTW, the same test in 2.4.6 works fine without any problem.

Regards.


-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
