Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUKGPbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUKGPbX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 10:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUKGPbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 10:31:23 -0500
Received: from [195.56.65.174] ([195.56.65.174]:20499 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261627AbUKGPbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 10:31:11 -0500
Subject: weird NFSv3 getaddr storm when fileserver upgraded to 2.6
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099841465.28539.152.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 07 Nov 2004 16:31:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've upgraded my NFS server from 2.4.25 to 2.6.9 at friday night and
the 2.4.x clients started to flood it with getaddr requests:
http://innocence.nightwish.hu/dap/getaddrstat/rpcga.html

 clients are 2.4.x boxes with increased 'ac' values:

10_1_1_1:~# cat /proc/mounts 
rootfs / rootfs rw 0 0
/dev/root / nfs rw,v3,rsize=4096,wsize=4096,acregmin=120,acregmax=120,acdirmin=120,acdirmax=120,hard,udp,nocto,nolock,addr=10.1.1.251 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
10.1.1.251:/mnt/htdocs /http nfs rw,v3,rsize=32768,wsize=32768,acregmin=120,acregmax=120,acdirmin=120,acdirmax=180,hard,udp,nocto,lock,addr=10.1.1.251 0 0

 there's no getattr flood for some time if I reboot the clients (like
saturday night), but it begins again at a point and only the reboot can
calm it down for a while. 2.4.25 worked fine for months.


-- 
dap

