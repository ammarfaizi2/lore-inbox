Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUGAMAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUGAMAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUGAMAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:00:31 -0400
Received: from palrel12.hp.com ([156.153.255.237]:23788 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264767AbUGAMA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:00:26 -0400
Subject: machine hangs - SLES9/NFS
From: Shylendra Bhat <shylendra.bhat@hp.com>
Reply-To: shylendra.bhat@hp.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088683221.3552.15.camel@nt2624.india.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jul 2004 17:30:21 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am looking answers for the following questions.

Is nfs file lock acquired by client, persistent across the nfs server
reboot?
I know that this feature was not there in NFSv3. Does NFSv4 supports
this?

Following is the exercise which I did to test nfs file lock.

I have two machines. One among them is the NFS server running on
SLES9(kernel 2.6.5-7.79). The other machine mounts the NFS exported
filesystem.

I have written a application which locks the files over this nfs mount.

After acquiring the lock, I am restarting the nfs service using
"rcnfsserver restart" command.

After the nfs service restart, the client fails to release the lock and
is in a hung state. If the mount directory is listed, it shows

"bash: cd: /export: Stale NFS file handle"

After this behavior of the client, server stops responding. Only way to
bring back the machine is reboot.

Any help is really appreciated.

Thanks & regards
Shylendra

