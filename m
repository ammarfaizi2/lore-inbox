Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTHRMMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271685AbTHRMLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:11:53 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:40078 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271418AbTHRMLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:11:33 -0400
Date: Mon, 18 Aug 2003 15:11:31 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test3mm2 reiserfs3.6.11 usb-storage
Message-ID: <Pine.LNX.4.56.0308181506390.13602@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, List!

In my journey to discover kernel 2.6 I get this error trying to reiserfsck
/dev/sda1 (usb flash disk, 128 MB)

bash-2.05b# reiserfsck --check /dev/sda1
reiserfsck 3.6.11 (2003 www.namesys.com)

*************************************************************
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will read-only check consistency of the filesystem on /dev/sda1
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you
do):Yes
Failed to open the journal device ((null)).

An strace tell me:
brk(0)                                  = 0x809c000
brk(0x809d000)                          = 0x809d000
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
_llseek(4, 65536, [65536], SEEK_SET)    = 0
read(4, "\370|\0\0\214\24\0\0\325\5\0\0\22\0\0\0\0\0\0\0\0\2\0\0"...,
4096) = 4096
_llseek(4, 131035136, [131035136], SEEK_SET) = 0
read(4, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377"...,
4096) = 4096
write(2, "Failed to open the journal devic"..., 44Failed to open the
journal device ((null)).
) = 44
fsync(4)                                = 0




I expect reiserfsck to treat this device as any other device.
Mount /dev/sda1 works.

Any advice, please?
Thank you!

P.S. More informations on request.

---
Catalin(ux) BOIE
catab@deuroconsult.ro
