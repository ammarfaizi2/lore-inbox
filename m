Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbTCMQWr>; Thu, 13 Mar 2003 11:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbTCMQWr>; Thu, 13 Mar 2003 11:22:47 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:38115 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S262436AbTCMQWr>; Thu, 13 Mar 2003 11:22:47 -0500
Message-ID: <3E70B2EC.EB695A80@attbi.com>
Date: Thu, 13 Mar 2003 11:33:48 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: [PATCH] self tuning scheduler 0.2
References: <5.2.0.9.2.20030312204553.00cd5068@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Everyone,

I'm still working on the window wiggle problem.  The problem is
that I'm expecting too much from the running average.  I wanted it
to provide long term history about the process's cpu use.  I also
wanted the process priority to change fairly quickly when the 
process is given some cpu time.  These are contradictory goals.

I'm working on a change which would use a short time constant for the
run_avg.  Rather than directly calculating the p->prio value from 
the run_avg, I will treat the p->prio as another filtered value.

I'm still working on the irman issue.  I'm thinking about counting
the number of levels of synchronous wakeup.  This would be used
to decide if the process should benefit from the sleep time.

Jim Houston - Concurrent Computer Corp.
