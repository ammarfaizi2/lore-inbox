Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUKVWK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUKVWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKVWFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:05:22 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:45032 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262399AbUKVWD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:03:28 -0500
Message-ID: <41A2622F.1070203@candelatech.com>
Date: Mon, 22 Nov 2004 14:03:27 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to compile x86 kernels on Opteron (Fedora core 3)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am trying to compile a 2.4.27 kernel for pentium-2 on an x86_64 Opteron
system (Fedora Core 3).  I tried editing the Makefile to add -m32 to the gcc
argument, and I added ARCH=i386 to all of the 'make' commands.

The first problem I see is that /sbin/genksyms does not exist on FC3.  I am
not sure where this is supposed to come from, but I coppied a version
from an different machine and it seems to work OK...

After that, the build still fails, complaining about conflicting types for
various things:

home/greear/kernel/2.4/linux-2.4.27.p2/include/asm/unistd.h:375: warning: conflicting types for built-in function '_exit'
...
sched.c:213: error: conflicting types for 'reschedule_idle'
sched.c:210: error: previous declaration of 'reschedule_idle' was here
sched.c:213: error: conflicting types for 'reschedule_idle'
sched.c:210: error: previous declaration of 'reschedule_idle' was here


I also tried building in a debian chroot (the binaries there is regular i386).
This mostly worked but it failed to build something down in the aic scsi code...

So, has anyone got a recipe for cross-compiling regular x86 2.4 and/or 2.6 kernels on an
x86_64 system?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

