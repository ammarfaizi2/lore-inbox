Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTKQApm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKQApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 19:45:42 -0500
Received: from aneto.able.es ([212.97.163.22]:28801 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263258AbTKQApl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 19:45:41 -0500
Date: Mon, 17 Nov 2003 01:45:39 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Lista Linux-BProc <bproc-users@lists.sourceforge.net>
Subject: Reading libs fails through NFS
Message-ID: <20031117004539.GA2155@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Anybody has any idea about why this fails:

    fd = open("/lib/libnss_files.so.2", O_RDONLY);
    res = read(fd,buf,512);

/lib is NFS mounted:

192.168.0.1:/lib on /lib type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)

and the read fails.
The original code does a getprotobyname("tcp") (netpipe), that fails when it
tries to read the same lib.

The node boots via PXE, with a version of libnss_files.so.2 on the /lib present
in the initrd, which is replaced by the mounted one.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc1-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
