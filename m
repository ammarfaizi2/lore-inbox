Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTEPIhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTEPIhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:37:36 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:56847 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S264376AbTEPIhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:37:35 -0400
Message-Id: <200305160841.h4G8fVu16877@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: techstuff@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Fri, 16 May 2003 11:48:07 +0300
X-Mailer: KMail [version 1.3.2]
References: <200305131415.37244.techstuff@gmx.net> <200305150545.h4F5j2u27109@Port.imtp.ilyichevsk.odessa.ua> <200305151024.37040.techstuff@gmx.net>
In-Reply-To: <200305151024.37040.techstuff@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2003 17:24, Boris Kurktchiev wrote:
> > Typical. So what makes you think kernel leaks memory?
>
> well the fact that before my swap was never used, and now .... I need
> to transcode something so I can show you how all swap is being used
> and non of the RAM (thus making programs run much slower, as is the
> case with transcode).

Well there might be problems with kernel being too swap-happy.
I.e. it swaps out application pages but keeps less precious
cache pages. These problems are not that easy to debug
(How do one prove that kernel swaps out 'wrong' pages?
What is 'wrong'? It's kind of subjective).

> > BTW, which version of procps do you have? Mine is 2.0.10,
> > 2.0.11 already exists.
>
> I believe I have 2.0.10.

No. 2.0.10 top printout look different:

 11:44:00  up 1 day, 18:52,  1 user,  load average: 0.25, 0.29, 0.23
63 processes: 60 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 41.8% user,  3.9% system,  0.0% nice,  0.0% iowait, 54.1% idle
Mem:   124616k av,  120448k used,    4168k free,       0k shrd,       4k buff
        87172k active,              18536k inactive
Swap:   76792k av,   21820k used,   54972k free                   55944k cached
--
vda
