Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUHQAId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUHQAId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHQAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:08:33 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:27022 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S268035AbUHQAG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:06:58 -0400
Message-ID: <41214C1E.9030003@bigpond.net.au>
Date: Tue, 17 Aug 2004 10:06:54 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates for 2.6.8
References: <Pine.SGI.4.53.0408161127580.663457@subway.americas.sgi.com> <1092675050.7416.0.camel@laptop.fenrus.com> <Pine.SGI.4.53.0408161255220.663830@subway.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.53.0408161255220.663830@subway.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Jacobson wrote:
>>>This is a fresh PAGG patch that applies cleanly to 2.6.8.
>>>There have been no major changes since the last PAGG patch I posted.
>>
>>are there (GPL) users of this yet ??
> 
> 
> SGI has job and CSA.  I don't know of non-SGI GPL projects making use of
> PAGG yet.

I'm thinking of adding a SCHED_IA scheduler class to the ZAPHOD CPU 
scheduler.  Tasks in this class would automatically get maximum 
interactive bonuses without having to go through ZAPHOD's normal 
mechanism for identifying interactive processes.  The main reason for 
doing this is that it is difficult to make rules for detecting 
interactive tasks that will successfully class the X server as 
interactive (which is necessary) but at the same time not also so 
classify tasks that aren't interactive.  This is because from time to 
time the X server's CPU usage rate gets very and also (as it serves 
multiple clients) its usage patterns aren't typical of most interactive 
tasks (i.e. lots of irregular sleep waiting for user input).

To make SCHED_IA useful, I would also make a PAGG client that would 
automatically set the scheduler classes of tasks to SCHED_IA if they 
exec() a binary designated by the sysadmin as an interactive program.

Peter
--
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

