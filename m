Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272403AbTGZBhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 21:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTGZBhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 21:37:15 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:43137
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272403AbTGZBhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 21:37:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.6.0-test1-G3
Date: Sat, 26 Jul 2003 11:56:32 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain> <20030725231314.A1073@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20030725231314.A1073@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261156.32209.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo

With this section of your patch:

+               if (!(p->time_slice % TIMESLICE_GRANULARITY) &&

that would requeue active tasks a variable duration into their running time 
dependent on their task timeslice rather than every 50ms. Shouldn't it be:

+               if (!((task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY) &&

to ensure it is TIMESLICE_GRANULARITY into the timeslice of a process?

Con

