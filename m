Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTH1CEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbTH1CEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:04:38 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:25323
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263415AbTH1CEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:04:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Date: Thu, 28 Aug 2003 12:11:43 +1000
User-Agent: KMail/1.5.3
Cc: warudkar@vsnl.net, linux-kernel@vger.kernel.org
References: <200308272138.h7RLciK29987@webmail2.vsnl.net> <200308272137.42632.kernel@kolivas.org> <20030827125310.15ebf8f9.akpm@osdl.org>
In-Reply-To: <20030827125310.15ebf8f9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281211.43945.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003 05:53, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > On Thu, 28 Aug 2003 07:38, warudkar@vsnl.net wrote:
> > > Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org,
> > > Rational Rose and Konsole at a time. All of these take extremely long
> > > time to startup. (approx > 5 minutes). Kswapd hogs the CPU all the
> > > time. X becomes unusable till all of them startup, although I can
> > > telnet and run top. Same thing run under 2.4.18 starts up in 3 minutes,
> > > X stays usable and kswapd never take more than 2% CPU.
> >
> > Yes I can reproduce this with a memory heavy load as well on low memory
> > (linking at the end of a big kernel compile is standard problem).
>
> It could be that recent changes to page reclaim which improve I/O
> scheduling have exacerbated this.
>
> Does this make a difference?

Tried it. No change. 

kswapd0 can hit 90% cpu at times unless the swappiness is increased.

Con

