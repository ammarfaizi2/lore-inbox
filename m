Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUJOAe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUJOAe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJOAe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:34:56 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:43750 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267454AbUJOAbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:31:22 -0400
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Zanussi <trz@us.ibm.com>, Robert Wisniewski <bob@watson.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
X-Message-Flag: Warning: May contain useful information
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	<416F0071.3040304@opersys.com> <20041014234603.GA22964@elte.hu>
	<416F14B4.8070002@opersys.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 14 Oct 2004 17:31:19 -0700
In-Reply-To: <416F14B4.8070002@opersys.com> (Karim Yaghmour's message of
 "Thu, 14 Oct 2004 20:07:16 -0400")
Message-ID: <52u0swddpk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Oct 2004 00:31:20.0169 (UTC) FILETIME=[4A950590:01C4B24E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Karim> cmpxchg (basically: try reserve; if fail retry; else
    Karim> write), with per-cpu buffers.

Not sure if I really understand the context where Ingo would use this,
but this lockless scheme doesn't seem to be safe for realtime; the
retry can potentially happen an arbitrary number of times.

 - Roland
