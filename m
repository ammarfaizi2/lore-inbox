Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCWGiX>; Fri, 23 Mar 2001 01:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRCWGiO>; Fri, 23 Mar 2001 01:38:14 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:55747 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129624AbRCWGiC>; Fri, 23 Mar 2001 01:38:02 -0500
Message-ID: <3ABAEED2.6020708@muppetlabs.com>
Date: Thu, 22 Mar 2001 22:36:02 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: werner.almesberger@epfl.ch, lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: /linuxrc query
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a initrd working, a /linuxrc on it that runs and executes. My question 
for the commands after pivot_root which works like a charm, thanks to initrd.txt,

what does redirecting stdin\stdout\stderr to dev/console achieve? I thought 
since the root is now the "new" root, dev/console will be used automatically? 
Also, why chroot, why not call init directly?
#exec chroot . sbin/init 3 <dev/console >dev/console 2>&1

Since the above never returns, what follows in not freed. Does this mean I have 
around 4-6 mb of ram being used up unnecessarily? Any solution?

#umount /initrd
#blockdev --flushbufs /dev/ram0    # /dev/rd/0 if using devfs


Thanks and Regards
Amit

