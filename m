Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263558AbSJHUJt>; Tue, 8 Oct 2002 16:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263563AbSJHUGs>; Tue, 8 Oct 2002 16:06:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:63977 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263558AbSJHUFz>;
	Tue, 8 Oct 2002 16:05:55 -0400
Message-ID: <3DA33BF1.3F43E5C0@digeo.com>
Date: Tue, 08 Oct 2002 13:11:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Williamson <robbiew@us.ibm.com>, Paul Larson <plars@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Test Project October Release Available
References: <OFFD6D99D7.513F8BA0-ON85256C4C.006B8A1F@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 20:11:29.0895 (UTC) FILETIME=[E39C3F70:01C26F06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Williamson wrote:
> 
> ...
> - Fix for "writev01" to check for EINVAL on      ( Paul Larson )
>   2.5.35 and above kernels
> 

whoa.  I've been asleep.  The 2.4 kernel _does_ return zero
if passed a zero segment count.

So we need to fix 2.5 to do that as well.  Sure, the spec
appears to allow either, but given that, we should preserve
the 2.4 behaviour.

Does that sound sane?    If so then we should unfix this fix
in LTP.  Sorry.
