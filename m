Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVDATI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVDATI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVDATI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:08:26 -0500
Received: from mail-5.integraonline.com ([204.130.255.157]:37565 "HELO
	integraonline.com") by vger.kernel.org with SMTP id S262850AbVDATIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:08:25 -0500
Message-ID: <002301c536ee$2b70b450$0a011eac@mimir>
From: "Luke Miller" <millerlu@integraonline.com>
To: <linux-kernel@vger.kernel.org>
Subject: Virtual Memory tuning and Buffers
Date: Fri, 1 Apr 2005 11:08:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a system that is running SUSE 8 kernel 2.4.21-273.  Recently we have
seen some interesting behavior with the virtual memory system.  When buffer
memory gets low (below 10 MB) the system re-allocates memory causes buffer
memory to go up to around 500 MB.  The re-allocation can take up to 30
minutes.  This system is an NFS server and during the re-allocation all the
NFSd's go to IO wait and the NFS clients gets delays trying to access files
on the NFS volumes.  I have generated some graphs that show this pretty
clearly, they are here:

http://www.integraonline.com/~millerlu/memory/

What I am trying to figure out is what is causing this memory allocations
and what can be done to tune them so it doesn't impact our production
applications when it happens.

Due to a clustering and file system product, Polyserve, we are unable to
upgrade to the 2.6 kernel at this time.

Any help would be appreciated.

Thanks,

Luke


