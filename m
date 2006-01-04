Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWADR0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWADR0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWADR0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:26:31 -0500
Received: from odin2.bull.net ([192.90.70.84]:15551 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S965121AbWADR0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:26:31 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: RT : 2.6.15-rt1 and net/ipv6/mcast.c
Date: Wed, 4 Jan 2006 18:32:38 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200601041832.39089.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 04/01/2006 18:27:18,
	Serialize by Router on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 04/01/2006 18:27:20,
	Serialize complete at 04/01/2006 18:27:20
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	On my i386 machine I can't compile. I have an error in net/ipv6/mcast.c
I correct the error doing the correction below. No more compilation problem.
Not yet tested. perhaps someone already submit it, but I received no mail today from vger.kernel.org

Index: linux/net/ipv6/mcast.c
===================================================================
--- linux.orig/net/ipv6/mcast.c
+++ linux/net/ipv6/mcast.c
@@ -224,7 +224,7 @@
 
        mc_lst->ifindex = dev->ifindex;
        mc_lst->sfmode = MCAST_EXCLUDE;
-       mc_lst->sflock = RW_LOCK_UNLOCKED;
+       mc_lst->sflock = RW_LOCK_UNLOCKED(mc_lst->sflock);
        mc_lst->sflist = NULL;
 
        /*
