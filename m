Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbVIBWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbVIBWwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVIBWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:52:06 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:49107 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161091AbVIBWwF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:52:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nro7CqiJBvEOH2z+2ppyhVldfQA7dljDCVnZ9E7ebMYKrxw/cwThkIZkSLrfIN76MUsay3y9eSKS8AxI80g2LE3PECS41P/2JGrOSnZ8lJXjIu2wse216rbOKww7q3ORpsRLKkbD+o9lTpEwDMjzgjPNDPug1U/KxA+1HPC7sdY=
Message-ID: <1c699250050902155251c18bb5@mail.gmail.com>
Date: Fri, 2 Sep 2005 19:52:02 -0300
From: Alan Menegotto <macnish@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: UML x86_86 Multicast Patch
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a silly error. 

In mcast_user.c from /usr/src/linux-2.6.13/arch/um/drivers when
multicast is enabled it cannot pass the "compile kernel" phase. The
following patch should fix the error. Please correct me if I'm wrong.

====================================================


--- /tmp/mcast_user.c   2005-09-03 19:59:15.000000000 -0300
+++ mcast_user.c        2005-09-03 19:59:32.000000000 -0300
@@ -13,7 +13,7 @@

 #include <errno.h>
 #include <unistd.h>
-#include <linux/inet.h>
+//#include <linux/inet.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/time.h>


-- 
Alan Menegotto
