Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWI3RNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWI3RNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWI3RNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:13:22 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:27347 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751307AbWI3RNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:13:21 -0400
Date: Sat, 30 Sep 2006 19:11:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: girish <girishvg@gmail.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH] include children count, in Threads: field present in
 /proc/<pid>/status (take-3)
In-Reply-To: <E78297DA-5F0F-40FA-A008-89264570B313@gmail.com>
Message-ID: <Pine.LNX.4.61.0609301908460.4615@yvahk01.tjqt.qr>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
 <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org> <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com>
 <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr>
 <CF74CE5D-42A1-4FF9-8C9B-682C5D6DEAE1@gmail.com> <Pine.LNX.4.61.0609292011190.634@yvahk01.tjqt.qr>
 <BEC70F7E-6143-4D8D-9800-A8538A152A18@gmail.com> <m1mz8ii8wj.fsf@ebiederm.dsl.xmission.com>
 <E78297DA-5F0F-40FA-A008-89264570B313@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  PID COMMAND      %CPU   TIME   #TH #PRTS #MREGS RPRVT  RSHRD  RSIZE  VSIZE
> 22429 top         16.6%  0:21.12   1    18    20  1.35M   684K  1.77M  26.9M
> ------------------------------------------------------------------------
> --------------------------------------------------------
>
> Comments/opinions?

I fail to see which column you mean.

#TH perhaps? I think, that can be calculated under linux by

 (a) counting the directories in /proc/22429/task using readdir
or
 (b) get the nlink of /proc/22429/task and subtract 2, which should give 
     the same as (a), and, better than (a), should also be atomic


Jan Engelhardt
-- 
