Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSAQNwL>; Thu, 17 Jan 2002 08:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSAQNvy>; Thu, 17 Jan 2002 08:51:54 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:17026 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S288742AbSAQNvl>; Thu, 17 Jan 2002 08:51:41 -0500
Message-Id: <200201171351.g0HDpdK05456@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: linux-kernel@vger.kernel.org
Subject: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Thu, 17 Jan 2002 14:51:39 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have to increase the number of anonymous filesystems the kernel can handle  
and found the array unnamed_dev_in_use fs/super.c and changed the array size 
from the default of 256 to 1024. Testing this patch by mounting more and more 
NFS-filesystems I found that still no more than 800 NFS mounts are possible. 
One more mount results in the kernel saying:

Jan 17 14:03:11 gl kernel: RPC: Can't bind to reserved port (98).
Jan 17 14:03:11 gl kernel: NFS: cannot create RPC transport.
Jan 17 14:03:11 gl kernel: nfs warning: mount version older than kernel

This bug can easily be reproduced any time. Does anyone know how to overcome 
this strange limitation? I am really in need of a solution to get a server 
running. Please help.

Thanks
Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz	http://www.uni-koblenz.de/~krienke
Rechenzentrum,                 	Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
