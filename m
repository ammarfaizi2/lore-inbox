Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTKYQRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKYQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:17:39 -0500
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:37306 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S261602AbTKYQRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:17:37 -0500
Date: Tue, 25 Nov 2003 16:17:36 +0000 (GMT)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6: can't lockf() over NFS
Message-ID: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-clamav-result: clean (1AOfse-0005lK-EQ)
X-uvscan-result: clean (1AOfse-0005lK-EQ)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get Debian testing to log in to GNOME when home directories are
mounted over NFS (Linux 2.6 client -> Linux 2.4-ac server). It claims not
to be able to lock a file..

I tried writing a trivial program to test lockf() and it returns ENOLCK 
over NFS, but succeeds locally. The client kernel offers some grumbles:

RPC: Can't bind to reserved port (13).
RPC: can't bind to reserved port.
nsm_mon_unmon: rpc failed, status=-5
lockd: cannot monitor a.b.c.d
lockd: failed to monitor a.b.c.d

[where a.b.c.d is our NFS server]

/sbin/rpc.statd is running on both client and server, and with a 2.4
kernel on the client (as the only change) GNOME logins and the lockf()  
test program work just fine.

Any ideas? I'm stumped at this point.

Cheers,

Matt
