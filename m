Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTIEUov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTIEUot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:44:49 -0400
Received: from web40404.mail.yahoo.com ([66.218.78.101]:29202 "HELO
	web40404.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262849AbTIEUoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:44:15 -0400
Message-ID: <20030905204414.74292.qmail@web40404.mail.yahoo.com>
Date: Fri, 5 Sep 2003 13:44:14 -0700 (PDT)
From: Joshua Weage <weage98@yahoo.com>
Subject: NFS client problems in 2.4.18 to 2.4.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this was not discussed previously, I couldn't find anything
relevant in the archives.

I am having problems with NFS clients getting stuck after reporting a
"nfs server not responding message".  The majority of the time the
mount starts working again when the nfs server load goes down. 
However, sometimes the mount on one client becomes completely
unresponsive, but all of the clients still work correctly.  Even after
letting it set for 2-3+ hours it still doesn't come back up.  I can
ping the server from the locked client and that works.  If I do a lazy
unmount and then remount the NFS disk it works again for awhile - but
tends to lock up again.  A standard umount doesn't work when the client
is hung.

This happens with all RedHat kernel releases 2.4.18 to 2.4.20.

I have tried tuning the NFS server by going to nfs utils 1.0.3 and by
increasing nfsd's and the socket buffer sizes.  I have also increased
the timeout on the clients to 2.0.  One thing that seems to help is to
enable async mode on the NFS server.  However, I've still seen the same
client hang with async turned on.

Machine Details:
12x Cluster nodes 2xAMD Athlon MP's, 100 MbEthernet
1x server 2xPentium III 1.13GHz, Adaptec 39160, Promise RM8000,
GigEthernet
1x Cisco 2924-T switch.

I'm running 8 CPU jobs, each cpu occasionally writes 120MB files to the
NFS disk.  The client lockup always occurs during these file writes.
The lockups have occured on several of the cluster nodes.

Any suggestions on what could be causing this?

Thanks,

Joshua Weage



=====


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
