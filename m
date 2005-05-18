Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVERALF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVERALF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVERAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:09:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60104 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262032AbVERAIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:08:43 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: christoph <christoph@scalex86.org>, George Anzinger <george@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, shai@scalex86.org,
       akpm@osdl.org
In-Reply-To: <200505180003.j4I03cJo008917@turing-police.cc.vt.edu>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	 <1116276689.28764.1.camel@mindpipe>
	 <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
	 <1116372341.32210.39.camel@mindpipe>
	 <200505180003.j4I03cJo008917@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 17 May 2005 20:08:36 -0400
Message-Id: <1116374916.2567.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 20:03 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 17 May 2005 19:25:41 EDT, Lee Revell said:
> 
> > How do you expect application developers to handle not being able to
> > count on the resolution of nanosleep()?  Currently they can at least
> > assume 10ms on 2.4, 1ms on 2.6.  Seems to me that if you are no longer
> > guaranteed to be able to sleep 5ms on 2.6, you would just have to
> > busywait.  Is it me, or does that way lie madness?
> 
> If you're running tickless, wouldn't a 'sleep 5ms' cause a timer event to be
> queued, and we wake up (approx) 5ms later?

Yes, exactly.  This is why I think going tickless is a good solution,
and CONFIG_HZ is bad, because with HZ=100 "sleep 5ms" would cause us to
sleep for 10ms.

Lee

