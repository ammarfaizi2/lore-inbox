Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVDVMcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVDVMcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 08:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVDVMcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 08:32:19 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:8071 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261307AbVDVMcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 08:32:16 -0400
Message-ID: <4268EEC9.8010305@ens-lyon.org>
Date: Fri, 22 Apr 2005 14:32:09 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Crash when unmounting NFS/TCP with -f
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

I'm using NFS (v2) over TCP (in a SSH tunnel).
Each time the SSH dies before a umount NFS, I have to umount -f
and I get a crash (only sysrq works).
Actually, the crash occurs a few seconds after umount -f.

It seems that killing SSH by hand does _not_ lead to crash.
But a long network failure does.
I remember seeing this bug several times with all stable releases
from 2.6.7 to 2.6.11. I didn't try with earlier versions.

I didn't see anything in the logs (after reboot). But I can't be sure
there was nothing in dmesg since I didn't get a chance to chvt 1 and
see console messages before rebooting (with sysrq).

Do you have any idea how to debug this ?

Thanks,
Brice
