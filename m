Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271174AbTHRBVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 21:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbTHRBVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 21:21:10 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48618
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271174AbTHRBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 21:21:07 -0400
Message-ID: <1061169664.3f402a00ae7b6@kolivas.org>
Date: Mon, 18 Aug 2003 11:21:04 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O16.2int
References: <1061152667.5526.26.camel@athxp.bwlinux.de> <1061156820.1775.32.camel@iso-8590-lx.zeusinc.com>
In-Reply-To: <1061156820.1775.32.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tom Sightler <ttsig@tuxyturvy.com>:

> Hi Con,

Hi Tom

> 1. -- Wine running Windows Media Player 6.4 works great when running in

Yes a well known problem now (see other threads about wine). Wine doing 
something very cpu intensive exhibits this due to a combination of wine 
breakage brought out by my scheduler tweaks causing priority inversion.

> 2. -- Adobe Acrobat 5.07 for Linux seems to have a very similar issue, a
> large complex document seems to starve out the whole system making the
> system feel locked up for several seconds.

Actually I've profiled acroread and it seems to be more a memory issue than a 
scheduler one per se. Something very inefficient about it's design and it 
behaves much worse as a mozilla plugin than standalone. Give it lots of cpu 
time and it just keeps doing more and more vm work.

> 3. -- It seems I can trigger the same kind of starvation by simply doing
> large selects in a Konsole window.  Selecting a large section of text

> Konsole issue, however, if another application is using a reasonable
> amount of CPU, say a video playing in Wine using ~50% CPU, then it seems
> easy to make this happen.  Once it happens it's very hard to recover,

This is because of wine, not the Konsole which behaves fine, but tips the 
combination of wine and something else over the edge.

I'm working on it. Thanks very much for your report.

Cheers,
Con
