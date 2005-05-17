Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVEQXZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVEQXZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEQXZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:25:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51141 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261998AbVEQXZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:25:46 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
From: Lee Revell <rlrevell@joe-job.com>
To: christoph <christoph@scalex86.org>
Cc: George Anzinger <george@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, shai@scalex86.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	 <1116276689.28764.1.camel@mindpipe>
	 <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
Content-Type: text/plain
Date: Tue, 17 May 2005 19:25:41 -0400
Message-Id: <1116372341.32210.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 17:55 -0700, christoph wrote:
> 
> Runtime? That seems to be a bad idea. It would be better to rewrite
> the timer subsystem to be able to work tickless.
> 

I agree 100%, I think it's especially crazy to allow selecting 100, 250,
500, etc, whether at runtime or compile time.  Might as well just go
tickless.

How do you expect application developers to handle not being able to
count on the resolution of nanosleep()?  Currently they can at least
assume 10ms on 2.4, 1ms on 2.6.  Seems to me that if you are no longer
guaranteed to be able to sleep 5ms on 2.6, you would just have to
busywait.  Is it me, or does that way lie madness?

Lee

