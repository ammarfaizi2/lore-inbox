Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVCXTto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVCXTto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCXTto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:49:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15236 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261738AbVCXTp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:45:26 -0500
Date: Thu, 24 Mar 2005 20:45:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
In-Reply-To: <16963.4331.617958.820012@tut.ibm.com>
Message-ID: <Pine.LNX.4.61.0503242032090.8883@yvahk01.tjqt.qr>
References: <20050323090254.GA10630@aurema.com> <16961.35656.576684.890542@tut.ibm.com>
 <20050324012948.GC25134@aurema.com> <16963.4331.617958.820012@tut.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>BTW, I just want to point out that there aren't any problems with
>read() in the version of relayfs included in the -mm tree (i.e. the
>'redux' version), since of course it doesn't support read().

Hm? Relayfs does not support a `cat /dev/relay/AChannelName` anymore?

>I'll continue maintaining the old relayfs for existing users (so
>thanks for the patch and the test code) so if the new version doesn't
>fit your needs, you'll still have the old version to fall back on.

Do you have the "new relayfs" as a "normal" file (outside any revision
control system), e.g. a diff patch?

>Hopefully the new version will still be useful for what you're trying to do
>- your old version used 'packet' mode with read().  The new relayfs
>only supports 'bulk' mode with mmap()
>- your old version used a single buffer, while the new relayfs only
>supports per-cpu buffers
>(BTW, the new relayfs doesn't have an option any longer to do automatic
>timestamping either).

I wanted to port the kernel side of my keylogger over to relayfs, but given
that API and functionality have now changed I am somewhat reluctant to do it.



Jan Engelhardt
-- 
