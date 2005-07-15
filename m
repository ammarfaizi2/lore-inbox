Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbVGOMiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbVGOMiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbVGOMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:38:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39046 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263270AbVGOMgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:36:41 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141614170.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121360561.3967.55.camel@laptopd505.fenrus.org>
	 <1121370122.7673.161.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
	 <1121381026.3747.14.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507141614170.19183@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121430820.3747.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Jul 2005 13:33:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-15 at 00:19, Linus Torvalds wrote:
> That's not what "jiffies" are about. If you want accurate time, use
> something else, like gettimeofday. The timeouts are _only_ relevant on the
> scale of a timer interrupt, since by definition that's what we're waiting
> for.

Ok makes sense - thats the same reason I wanted jiffies() - the timer
interrupt resolution might be useless at the given time (eg seconds). It
does mean people using while loops testing against jiffies are generally
wrong still.

Alan

