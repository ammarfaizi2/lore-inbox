Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUKDKVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUKDKVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbUKDKVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:21:20 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:9345 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262154AbUKDKVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:21:18 -0500
Date: Thu, 4 Nov 2004 11:23:45 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104102345.GA23673@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
	linux-kernel@vger.kernel.org
References: <20041103152531.GA22610@DervishD> <418962B0.3080806@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418962B0.3080806@tmr.com>
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
> >    Or write a little program that just 'wait()'s for the specified
> >PID's. That is perfectly portable IMHO. But I must admit that the
> >preferred way should be killing the parent. 'init' will reap the
> >children after that.
> You can't wait() for the process, you have to use waitfor(), and the 
> last time I tried that it didn't work, although I don't remember the 
> symptom beyond that.

    You can't wait for other's children. OTOH, if we talk about your
children, you can do wait() or waitpid() (I assume that you referred
to waitpid(), since there isn't waitfor() AFAIK). The only difference
is that wait suspends the process until information from a child is
available.

    If you are talking about others' children, then your call to
waitpid() (or wait()) failed with ECHILD: not your child.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
