Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUJOCBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUJOCBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUJOCBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:01:31 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:33458 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S268074AbUJOCB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:01:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Oct 2004 22:00:51 -0400 (EDT)
To: Roland Dreier <roland@topspin.com>
Cc: karim@opersys.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Zanussi <trz@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
In-Reply-To: <52u0swddpk.fsf@topspin.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<416F0071.3040304@opersys.com>
	<20041014234603.GA22964@elte.hu>
	<416F14B4.8070002@opersys.com>
	<52u0swddpk.fsf@topspin.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16751.12005.419748.661651@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theoretically a problem, in practice not, i.e., good enough for soft/normal
real-time, not hard real-time; probably wouldn't want my heart monitor on
it, but then I wouldn't be using Linux for that either :-)

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com


Roland Dreier writes:
 >     Karim> cmpxchg (basically: try reserve; if fail retry; else
 >     Karim> write), with per-cpu buffers.
 > 
 > Not sure if I really understand the context where Ingo would use this,
 > but this lockless scheme doesn't seem to be safe for realtime; the
 > retry can potentially happen an arbitrary number of times.
 > 
 >  - Roland
