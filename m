Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbTDFGj7 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTDFGj7 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:39:59 -0500
Received: from wall.ttu.ee ([193.40.254.238]:36360 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S262840AbTDFGj6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 01:39:58 -0500
Date: Sun, 6 Apr 2003 09:51:11 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: linux-kernel@vger.kernel.org
Subject: nfs issues
Message-ID: <Pine.GSO.4.53.0304060937020.17774@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I noticed something similar discussed before but I found no answer..

I downloaded a 700M ISO to a file server and then, as usually, tried
to md5sum it. When I md5summed it where I downloaded it, it was OK.
However, when I did md5sum over NFS, I got _different answers every
time I tried_. Also, I recieved much of these errors on the client
machine during the md5summing period:
"NFS: server cheating in read reply: count 8192 > recvd 1000"
(Server side did not give any errors.)

I have seen this error for many times before but I didn't count it
as anything serious. But when md5sum fails like that, then it means
NFS actually screws the data aswell, right?

The server is 2.4.20
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
# CONFIG_NCPFS_NFS_NS is not set

And client is 2.5.66-bk10
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set

I think that these errors started to come along after I went over to 2.5.
