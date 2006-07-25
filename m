Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWGYX5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWGYX5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWGYX5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:57:19 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:5911 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030273AbWGYX5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:57:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lOS7G/YjUMUxOHR+FvaZDQRhCZ0fqRgfZK/YlYXbp5SM3S3a/Y+AXkn/W72DlFlHxIf0IT/ciuU3zctNHF3v5JlLRhb2IAq7eLfG+uzFiTD797SQW0QMhw16CPkmKtbJIHd8evp22hAS4fb7pTJpRvdlnh8NLqPe4C1CpQg995Y=
Message-ID: <6bffcb0e0607251657w47697883n74bab2255fd44ece@mail.gmail.com>
Date: Wed, 26 Jul 2006 01:57:17 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: [2.6.18-rc2-gabb5a5cc BUG] Lukewarm IQ detected in hotplug locking
Cc: "Linus Torvalds" <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This looks like an abb5a5cc6bba1516403146c5b79036fe843beb70 commit
(I'm not sure, I'll check this "tomorrow").

Jul 24 20:46:50 ltg01-fedora kernel: Lukewarm IQ detected in hotplug locking
Jul 24 20:46:50 ltg01-fedora kernel: BUG: warning at
/usr/src/linux-git/kernel/cpu.c:38/lock_cpu_hotplug()
Jul 24 20:46:50 ltg01-fedora kernel:  [<c0132891>] lock_cpu_hotplug+0x40/0x63
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026a364>]
__cpufreq_driver_target+0xf/0x48
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026affb>]
cpufreq_governor_performance+0x17/0x1c
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026992e>] __cpufreq_governor+0x63/0x114
Jul 24 20:46:50 ltg01-fedora kernel:  [<c0269abe>]
__cpufreq_set_policy+0xdf/0xe6
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026a58a>]
store_scaling_governor+0x11d/0x148
Jul 24 20:46:50 ltg01-fedora kernel:  [<c0269e27>] handle_update+0x0/0x5
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026a46d>]
store_scaling_governor+0x0/0x148
Jul 24 20:46:50 ltg01-fedora kernel:  [<c026a0c0>] store+0x2e/0x3e
Jul 24 20:46:50 ltg01-fedora kernel:  [<c018c801>] sysfs_write_file+0x8c/0xb4
Jul 24 20:46:50 ltg01-fedora kernel:  [<c018c775>] sysfs_write_file+0x0/0xb4
Jul 24 20:46:50 ltg01-fedora kernel:  [<c015be27>] vfs_write+0xa1/0x143
Jul 24 20:46:50 ltg01-fedora kernel:  [<c015c417>] sys_write+0x3c/0x63
Jul 24 20:46:50 ltg01-fedora kernel:  [<c0102d51>] sysenter_past_esp+0x56/0x79

Here is a config file
http://www.stardust.webpages.pl/files/2.6-git/18-rc2/git-config

Here is dmesg http://www.stardust.webpages.pl/files/2.6-git/18-rc2/git-dmesg

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
