Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTE0SGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTE0R4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:56:32 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:27142 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264063AbTE0R4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:56:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:08:43 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305272004.02376.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 19:57, Marcelo Tosatti wrote:

Hi Marcelo,

> > I do, people I know do also, numbers of those people only _I_ know are
> > about ~30. I've reported this problem over a year ago while 2.4.19-pre
> > time.
> Can you please try to reproduce it with -aa?
not again ;)

I've tried almost all known kernel tree's around, every kernel has the same 
effect. I even tried SuSE and Redhat Kernels.

I've 'wasted' tons of time just find a solution for it.

Andrea introduced, to address _exact_ this problem (pauses, stops, mouse is 
dead etc.), his lowlatency elevator. Side effect: decreases i/o throughput, 
and the "pauses/stops" are still there. Much less but not gone.

The _only_ workaround yet (known to the public) is to change nr_requests in 
drivers/block/ll_rw_blk.c from 128 to 4 which gives a performance hit of 
about 40% (not acceptable in any way).

.oO( I am quite sure I've mailed you all this stuff privately in response to 
      your private mail to me ;) )Oo.

ciao, Marc

