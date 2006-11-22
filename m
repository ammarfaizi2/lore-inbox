Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967024AbWKVDXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967024AbWKVDXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967025AbWKVDXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:23:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967024AbWKVDXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:23:42 -0500
Date: Wed, 22 Nov 2006 04:23:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <nigel@suspend2.net>,
       pavel@suse.cz, linux-pm@osdl.org
Subject: 2.6.19-rc5-mm2: suspend related BLOCK=n compile error
Message-ID: <20061122032341.GV5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp-freeze-filesystems-during-suspend-rev-2.patch causes the 
following compile error with CONFIG_BLOCK=n:

<--  snip  -->

...
  CC      kernel/power/process.o
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'freeze_processes':
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:124: error: implicit declaration of function 'freeze_filesystems'
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'thaw_processes':
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:189: error: implicit declaration of function 'thaw_filesystems'
make[3]: *** [kernel/power/process.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

