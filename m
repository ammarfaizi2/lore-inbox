Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUKDVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUKDVKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKDVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:10:22 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:18564 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262445AbUKDVJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:09:10 -0500
Date: Thu, 4 Nov 2004 22:11:38 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104211138.GB25290@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
	linux-kernel@vger.kernel.org
References: <20041104102345.GA23673@DervishD> <418A83EA.9090106@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418A83EA.9090106@tmr.com>
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
> >    If you are talking about others' children, then your call to
> >waitpid() (or wait()) failed with ECHILD: not your child.
> That's what happened when I tried it a few months ago. I suppose one 
> could try sending a SIGCHLD to the parent and see if it does something 
> helpful.

    Probably it won't do. If the zombies are there due to a signal
delivery problem, sending a SIGCHLD to the parent will (probably)
solve the problem. But the common case is that the parent is screwed
up or simply so badly programmed that the only way of getting rid of
the zombies is to kill the parent...

    Anyway I suppose that sending the SIGCHLD won't do any harm so it
may be worth trying.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
