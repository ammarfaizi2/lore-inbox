Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTIMRRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTIMRRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:17:14 -0400
Received: from hal-4.inet.it ([213.92.5.23]:37878 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261917AbTIMRRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:17:13 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: test5 and JFS on /: problems, anyone?
Date: Sat, 13 Sep 2003 19:17:11 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309131917.11731.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using JFS on / partition on a couple of machines and when I've installed 
2.6.0-test5 I've got fs corruption on both. I can't say if the problems are 
happened during normal operation or at boot time, but I've noticed it only 
after a reboot. Some files disappeared (i.e. /etc/X11/Xsession), some others 
unreadable or inaccessible to any operation apart ls (lsattr, chattr, chown, 
cat, and so on, with permission denied); for example on both systems 
/var/lock/subsys was missing. Now fsck locks indefinitely at pass 1 and the 
same happens during operations that requires access to some files (i.e. rpm 
--rebuilddb), but ctrl-c works and the process is terminated.
Machines are quite similar but not exactly the same:
P IV on both, one with SMP kernel (for HT processor); on one machine I've got 
jfs utils rev. 1.0.24 and 1.1.2 on the other. 
On the same HW test4 works just fine on this respect, I've recompiled test5 
using the same config of test4 (make oldconfig).
No HW errors on dmesg.
I would like to know if someone else is having problmes with test5 and JFS or 
if this is only bad luck :)
I've still the corrupted FS handy so I can made some checks, if needed.


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

