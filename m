Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUBUXgt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbUBUXgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 18:36:49 -0500
Received: from mailbox.univie.ac.at ([131.130.1.27]:40878 "EHLO
	mailbox.univie.ac.at") by vger.kernel.org with ESMTP
	id S261624AbUBUXgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 18:36:48 -0500
X-Spam-Flags: <.WHOIS-RFC-IGNORANT.@mailbox.univie.ac.at>[212.186.57.219:chello212186057219.411.14.univie.teleweb.at]<vcpc.univie.ac.at>
Message-ID: <4037EB6D.9080902@vcpc.univie.ac.at>
Date: Sun, 22 Feb 2004 00:36:13 +0100
From: Willy Weisz <weisz@vcpc.univie.ac.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: de-at, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Client looses NFS handle (kernel 2.6.3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-ZID-Univie-Metrics: imap 4241; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The client looses the handle to a statically mounted NFS file system. A 
user sees
a stale handle in "df" and can't access files and directories.

When root issues a "df" or accesses a file or directory on the NFS file 
system,
it gets a correct result.

Thereafter a normal user also can access files and directories on the 
NFS file system.
After a short time the NFS handle becomes stale again.
/var/log/messages contains the lines:
Feb 21 23:33:50 gsr108 kernel: RPC: Can't bind to reserved port (13).
Feb 21 23:33:50 gsr108 kernel: RPC: can't bind to reserved port.
after a user tries to access a file on the NFS file system.
The NFS server runs kernel version 2.4.23 SMP. Client NFS 2.4.23 works.

The filesystem is mounted with the following options in /etc/fstab:
rw,bg,hard,intr,rsize=8192,wsize=8192

We are stuck and can't upgrade to 2.6.x with this bug.

Regards

Willy Weisz
-----------------------------------------------------------
Willy Weisz

European Centre for Parallel Computing at Vienna (VCPC)
                 Liechtensteinstrasse 22
                 A-1090 Wien
Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
                e-mail: weisz@vcpc.univie.ac.at

