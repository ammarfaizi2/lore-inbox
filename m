Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWHDTED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWHDTED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161366AbWHDTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:04:03 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:15560 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161364AbWHDTEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:04:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fLM3hFzitYwy7bjYABveE6pEVnV3NOeMNDiDs7BTfvL3nhBiFKJ3JNTybwgZ9f+numV/qs07mJUpqxI4+uPKWMfEkG+ECejeItN/lT2aDyLUoN/LFNdmiBNGagScSGXBAcd7V8Yc1aYidFmiZ7ghiEWOWjKylEA+5VKX7Ta2cQM=
Message-ID: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
Date: Fri, 4 Aug 2006 21:04:01 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Cc: "Dave Jones" <davej@codemonkey.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was reported
http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1867.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0608.0/0675.html

It's time to use git-bisect.

BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
 [<c0132a04>] unlock_cpu_hotplug+0x2c/0x54
 [<c013a2ec>] stop_machine_run+0x2e/0x34
 [<c0135686>] sys_init_module+0x15a0/0x178a
 [<c015b7b7>] do_sync_read+0xb6/0xf1
 [<c0102d51>] sysenter_past_esp+0x56/0x79

Here is a config file
http://www.stardust.webpages.pl/files/2.6-git/18-rc3/config
Here is dmesg http://www.stardust.webpages.pl/files/2.6-git/18-rc3/dmesg

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
