Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUHETCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUHETCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUHETAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:00:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:663 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267903AbUHES7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:59:52 -0400
Message-Id: <200408051859.i75Ix1Y16640@owlet.beaverton.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, mbligh@aracnet.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.8-rc2-mm2, schedstat-2.6.8-rc2-mm2-A4.patch 
In-reply-to: Your message of "Thu, 05 Aug 2004 11:36:27 PDT."
             <20040805113627.13e0feab.akpm@osdl.org> 
Date: Thu, 05 Aug 2004 11:59:01 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian's problem was due to using schedstats on a non CONFIG_SMP system,
which I hadn't tried since sched-domains was added.  I'll send a patch
to you separately against this tree

    http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2.

to address that.

Since schedstats digs deep into the internals of the scheduler, major
scheduler changes will probably always require some major revamping
of schedstats, at least to deprecate old counters and possibly to add
new ones.  I think, though, that after this initial settling-in period
minor scheduler changes should result in just tweaks to schedstat.

Rick
