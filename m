Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSIBNB1>; Mon, 2 Sep 2002 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSIBNB1>; Mon, 2 Sep 2002 09:01:27 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:56569
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318282AbSIBNB0>; Mon, 2 Sep 2002 09:01:26 -0400
Subject: Re: Problem with the O(1) scheduler in 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208301822200.2042-100000@boris.prodako.se>
References: <Pine.LNX.4.44.0208301822200.2042-100000@boris.prodako.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 02 Sep 2002 14:07:13 +0100
Message-Id: <1030972033.3490.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 22:53, Tobias Ringstrom wrote:
> While the O(1) scheduler has performed very well for me in most
> situations, I have one big problem with it.  When running a Counter-Strike
> game server on Linux 2.4.19 with the sched-2.4.19-rc2-A4 patch applied,
> the server process is niced from the default value of 15 (interactive) to
> 25 (background).  This means that every time crond wakes up or a mail
> arrives the game latency becomes extremely bad and the users experience
> lag.
> 
> The process takes around 70% CPU on these occasions, so I'm surprised that
> the task is not considered to be interactive.
> 
> This does not happen with stock 2.4.19.  Do you have any ideas why this
> regression is happening?

It isnt a regression, its a bug fix. The nice value is now being
honoured properly.

