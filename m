Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRJ3Qbz>; Tue, 30 Oct 2001 11:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRJ3Qbp>; Tue, 30 Oct 2001 11:31:45 -0500
Received: from mxfw.q-free.com ([62.92.116.8]:1809 "HELO mxfw")
	by vger.kernel.org with SMTP id <S280002AbRJ3Qbc> convert rfc822-to-8bit;
	Tue, 30 Oct 2001 11:31:32 -0500
Message-ID: <3BDED5D5.7C985134@q-free.com>
Date: Tue, 30 Oct 2001 17:31:17 +0100
From: Audun Jan Myrhol <audun@q-free.com>
Organization: q-free.com
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with SanDisk Compact Flash disks on IDE with kernel 2.4.x
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a lot of problems when trying to use a SanDisk Compact Flash
card with an IDE adapter as an IDE disk on kernel 2.4.x.
The Compact Flash disks may be used perfectly with the old age MSDOS
6.2 either alone or with a normal IDE disk on the same controller. It
is also possible to use the Compact Flash with success with kernel
2.2.14 and 2.2.16.

When used with kernel 2.4.x (tried 2,5,7,12,13, various compile
options) I have so far found it impossible to get the Compact Flash
working together with a standard IDE disk on the same controller. A
typical scenario is: Standard IDE disk as hda full system installed,
the CF with IDE adapter as hdb (empty/unformatted/dos formatted /ext2
formatted, tried "everything"). The boot sequence is normal until LILO
attempts to mount VFS. Then no disk is accessible on the IDE bus, and
I get kernel panic. Identical sympthoms are seen when using an IDE
FlashDrive from SanDisk.

I have installed a stripped down system based on kernel 2.2.14 on one
CF disk as hda, that works, with or without a normal IDE disk as hdb.
If I change the kernel on that CF to 2.4.13 and removes the hdb IDE
disk, the kernel is able to mount VFS and complete normal boot.

Any ideas for fix / workaround, I haven't found anything in the
archives?

System info:

CPU card: Aaeon 6890B with Celeron and 440BX chipset. 
SanDisk 64 MB Compact Flash card: SDCFB-64 or
SanDisk 96 MB Flash Drive (IDE interface) : SD25B-96

Audun Myrhol
R&D engineer

((((((((((((((((((( 8-)§ ))))))))))))))))))))))
Q-Free Tolling AS        
N-7443 Trondheim          MAILTO:audun@q-free.com
Norway                    http://www.q-free.com
