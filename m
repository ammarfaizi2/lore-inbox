Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUDGCVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUDGCVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:21:20 -0400
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:41298 "HELO
	boetes.org") by vger.kernel.org with SMTP id S263448AbUDGCVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:21:18 -0400
Date: Wed, 7 Apr 2004 04:21:29 +0200
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: With recent kernels find gets stuck at nothing.
Message-ID: <20040407022151.GA8445@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To debug why the locate cronjob got stuck I tracked down is going on:

So I run this little script:

#!/bin/sh
find / ! \( -fstype jfs -or -fstype reiserfs -or -fstype ext2 -or -fstype ext3 -or -fstype afs -or -fstype xfs \) -prune -or -path /tmp -prune -or -path /var/tmp -prune -or -path /var/spool -prune -or -path /usr/tmp -prune -or -path /mnt -prune -or -print

Now the odd thing happens quite frequently: It's gets stuck just in the
middle of some directory. When this happens I can not start any new
applications. It stays this way until I go to the firebird window which
gets itself back from swap memory (it seems) and then the find command
continues.

I run kernel-2.6.5 with jfs as filesystem and I do not use
preempting. I have an athlon 1700+ and 256mb memory.


I hope this is sufficient information to be able to repeat this
problem. Otherwise please let me know what additional information you
want to know.



# Han
