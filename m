Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUKDUyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUKDUyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUKDUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:53:16 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:8322 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262427AbUKDUvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:51:00 -0500
Date: Thu, 4 Nov 2004 21:53:18 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104205318.GA25290@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
	Valdis.Kletnieks@vt.edu,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <20041104102655.GB23673@DervishD> <418A816C.3060705@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418A816C.3060705@tmr.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bill :)

 * Bill Davidsen <davidsen@tmr.com> dixit:
> >    If init is the parent, all works ok, just wait a bit and all
> >those zombies will really die ;)
> Actually the ones in i/o probably won't, since the kernel either missed 
> the completion or didn't time out if the hardware missed sending the 
> int. And even plain non-i/o zombies, just how long "a bit" are you 
> proposing?

    A zombie *is already dead*, not stuck in some uninterruptible
queue in the kernel, so they will be ripped, sure. My last sentence
in the paragraph above may be confusing: when I said 'really die' I
meant 'be ripped'?

> Over Thanksgiving weekend I will try to look at the init code and see if 
> a signal could be used to initiate a forced reap without waiting for the 
> timer. By "look at" I mean not only "could I do that" but is it a good 
> thing to do, before someone starts trying to explain that it's going to 
> do something evil not to wait for the timer...

    Don't look: just send SIGCHLD to init. That will do.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
