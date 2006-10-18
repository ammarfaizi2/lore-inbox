Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWJRHY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWJRHY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJRHY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:24:58 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:10906 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP
	id S1750900AbWJRHY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:24:57 -0400
Message-ID: <4535D6BD.5030302@netbauds.net>
Date: Wed, 18 Oct 2006 08:24:45 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.0.7) Gecko/20060929 SeaMonkey/1.0.5
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18.1 capset() returns EPERM for bind running as root
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was working on 2.6.15.6.

# uname -a
Linux xxxxxxxx 2.6.18.1 #5 SMP Wed Oct 18 07:08:29 BST 2006 i686 i686 
i386 GNU/Linux
# id
uid=0(root) gid=0(root) 
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)

# strace /opt/named/named-9.3.1beta2
...SNIP...

getuid32()                              = 0
capset(0x19980330, 0, {CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_CHROOT|CAP_SYS_RESOURCE, CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_CHROOT|CAP_SYS_RESOURCE, CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_CHROOT|CAP_SYS_RESOURCE}) = -1 EPERM (Operation not permitted)
write(2, "named-9.3.1beta2: ", 18named-9.3.1beta2: )      = 18
write(2, "capset failed: Operation not per"..., 109capset failed: Operation not permitted: please ensure that the capset kernel module is loaded.  see insmod(8)) = 109
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?
#


-- 
Darryl L. Miles


