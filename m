Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272808AbRIGSQv>; Fri, 7 Sep 2001 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272810AbRIGSQl>; Fri, 7 Sep 2001 14:16:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272808AbRIGSQb>; Fri, 7 Sep 2001 14:16:31 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /proc/cpuinfo bad cache info
Date: 7 Sep 2001 11:16:49 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9nb2uh$346$1@cesium.transmeta.com>
In-Reply-To: <3B98DD93.4BDD367C@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3B98DD93.4BDD367C@uni-mb.si>
By author:    David Balazic <david.balazic@uni-mb.si>
In newsgroup: linux.dev.kernel
> 
> In recent 2.4.x kernels the "Cache: " line in /proc/cpuinfo
> reports the amount of the L1 cache or L2 cache or L3 cache or
> some combination of them, depending on what code is executed
> for this ( different for different CPU types ).
> 
> Somebody should decide what information should be reported in that
> line and then fix the code.
> 

We already DO report the information we care about -- the SMP
weighting value -- and thus the code is correct.  The value indicates
how much data is localized to that CPU and therefore how expensive it
is to reschedule a process elsewhere.

Anything that reports anything else is buggy.  This includes things
like adding in the L1 cache in an inclusive cache design, or reporting
the L3 cache when it is a shared cache in the chipset.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
