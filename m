Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVD3X2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVD3X2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVD3X2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:28:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21739 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261457AbVD3X2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:28:15 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050422062714.GA23667@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <20050421073537.GA1004@elte.hu>  <20050422062714.GA23667@elte.hu>
Content-Type: multipart/mixed; boundary="=-h9aikHK2/K1Q03OEi+e8"
Date: Sat, 30 Apr 2005 19:28:13 -0400
Message-Id: <1114903693.12664.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h9aikHK2/K1Q03OEi+e8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-22 at 08:27 +0200, Ingo Molnar wrote:
> i have released the -V0.7.46-01 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Ingo,

With Mingming's patch to resolve the ext3 allocate-with-reservation
latency, it looks like we are finally getting close to the lower limit
that can be achieved with PREEMPT_DESKTOP.  I've attached the trace of
the lowest latency over several days of testing with
2.6.12-rc3-RT-V0.7.46-02 + Mingming's patch.  It's only 127 usecs, and
IIRC you mentioned previously that this code path can't be made
preemptible in !PREEMPT_RT.

Since Mingming's patch will have to live in -mm for a while, can it be
added to the RT patchset as well?

http://lkml.org/lkml/2005/4/22/127

Lee

--=-h9aikHK2/K1Q03OEi+e8
Content-Disposition: attachment; filename=signal-delivery-trace.bz2
Content-Type: application/x-bzip; name=signal-delivery-trace.bz2
Content-Transfer-Encoding: base64

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
aP8YaZMtNf/i7kinChITt8eegA==


--=-h9aikHK2/K1Q03OEi+e8--

