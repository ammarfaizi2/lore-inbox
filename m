Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTHMEks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271324AbTHMEks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:40:48 -0400
Received: from sngrel5.hp.com ([192.6.86.210]:47827 "EHLO sngrel5.hp.com")
	by vger.kernel.org with ESMTP id S271089AbTHMEkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:40:47 -0400
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: KDB in the mainstream 2.4.x kernels?
Date: Wed, 13 Aug 2003 14:40:31 +1000
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.08.13.04.40.27.59654@sourcefrog.net>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 22:43:57 +0200, Andi Kleen wrote:

> KDB is usually not useful for debugging hangs on desktop boxes (and even
> many servers) because you have usually X running. When the machine crashes
> and goes in KDB you cannot see the text output and debug anything. I
> learned to type "go<return>" blind when I had still an KDB aware kernel,
> but it's not very useful overall.

Perhaps in the case where the console is on a vt, kdb could try to
switch to the right vc before presenting its prompt?  I realize calling into
the vc code might be risky but it seems like there's not much to lose.  
(If you do have a bug in say the agp driver then you need a serial
console...)   If it works, you'll be able to debug and continue.

It could even set the colors to white on blue. :-)

-- 
Martin

