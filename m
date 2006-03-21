Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWCUMlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWCUMlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCUMlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:41:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751597AbWCUMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:41:08 -0500
Date: Tue, 21 Mar 2006 13:41:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sfrench@samba.org
Cc: linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: CIFS: some problems
Message-ID: <20060321124107.GA3890@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I discovered two other problems with CIFS:

I'm connecting to a Samba server.

This is with the same computers as my now fixed hangs, but this time I 
am trying to copy data to the server.

All the below was observed on an otherwise mostly idle machine.

With 2.6.16, the data transfer make the whole computer very sluggish, 
this seems to be fixed in 2.6.16-rc6-mm2. But the following issues 
remain:

When copying with "cp" or "mc" to the share and suspending the program 
copying with ^Z, the data transfer seems to continue.

When running "sync" from another shell during a data transfer, the sync 
hangs. After killing cifsd, "sync" returns immediately.

CIFS options in my kernel:
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set

I'm mounting with (slightly anonymized):
mount -t cifs -o user="foo",ip=11.22.33.44 //DAT/bar bar

I'm using the smbfs 3.0.21b-1 package from Debian.

I'm using an e100 network card with a 10 MBit/s connection.

Any other information I can provide for helping to debug this problem?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

