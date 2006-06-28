Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWF1MPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWF1MPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWF1MPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:15:12 -0400
Received: from cv3.cv.nrao.edu ([192.33.115.2]:62172 "EHLO cv3.cv.nrao.edu")
	by vger.kernel.org with ESMTP id S1423310AbWF1MPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:15:11 -0400
Message-ID: <44A272CA.5000209@nrao.edu>
Date: Wed, 28 Jun 2006 08:15:06 -0400
From: Rodrigo Amestica <ramestic@nrao.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Rodrigo Amestica <ramestic@nrao.edu>
Subject: vmalloc kernel parameter
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact postmaster@cv.nrao.edu for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.44, required 5,
	autolearn=disabled, ALL_TRUSTED -1.44, USER_IN_WHITELIST -100.00)
X-MailScanner-From: ramestic@nrao.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm having troubles when using the vmalloc kernel parameter.

My grub config looks as shown below. If I set vmalloc to anything
bigger than 128M (the default) then the kernel will not boot and it
will log the following on the console:

VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel Panic - not syncing: VFS Unable to mount root fs on
unknown-block(0,0)

If I specify 128M or less then the kernel will boot just fine and
/proc/meminfo will show the effect in VmallocTotal.

Any hint on what I'm crashing with?

thanks,
  Rodrigo

ps: my kernel version is 2.6.15.2, and my machine is a dual opteron
with 2GB of ram

title with vmalloc
         root (hd0,0)
         kernel /boot/vmlinuz ro root=LABEL=/ vmalloc=256M
         initrd /boot/initrd.img
