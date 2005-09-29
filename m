Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVI2JVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVI2JVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVI2JVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:21:55 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:32763 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S1751241AbVI2JVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:21:54 -0400
Date: Thu, 29 Sep 2005 05:24:13 -0400
From: Balazs Csak <bcsak@cfa.harvard.edu>
To: linux-kernel@vger.kernel.org
Subject: mm/rmap.c bug(?) in the 2.6.12 kernel
Message-Id: <20050929052413.42816b81.bcsak@cfa.harvard.edu>
Organization: Center for Astrophysics
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,




I've got an oops on a dual Opteron machine that's running on 2.6.12.3
kernel. Under heavy load the system hangs and we get this oops on the
screen:



...

<ffffffff8013477d>{printk+141} <ffffffff8012db83>{try_to_wake_up+915}
<ffffffff8010e445>{error_exit+0} <ffffffff80170ec6>{page_remove_rmap+38}
<ffffffff80168fde>{unmap_vmas+1342} <ffffffff8016ea63>{exit_mmap+163}
<ffffffff801317a1>{mmput+49} <ffffffff80136432>{do_exit+338}
<ffffffff80136f5f>{do_group_exit+239}
<ffffffff8010da46>{system_call+126}


Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48
RIP <ffffffff801318f6>{mm_release+86} RSP <ffff8100daf26308>
CR2: 0000000000000040
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!





This problem has been described here, earlier:

http://seclists.org/lists/linux-kernel/2005/May/6369.html




Our setup is: 2x Opteron 246, Tyan Thunder K8S MB, 3ware 9500-8,
4 G RAM, Fedora Core 3 x86_64, 2.6.12.3 kernel.



Memtest shows nothing special...


Does anyone know something useful for this problem?




Thanks in advance,


Balazs



P.S.: Please CC me on answers/comments, I don't regularly read the
mailing list.
