Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTJSORO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJSOQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 10:16:11 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:63644 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261820AbTJSOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 10:15:58 -0400
Message-ID: <3F929C82.4020904@softhome.net>
Date: Sun, 19 Oct 2003 16:15:30 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <H2MN.3cm.7@gated-at.bofh.it> <H366.3IC.9@gated-at.bofh.it> <H3fO.3VO.13@gated-at.bofh.it> <H3IO.4yt.9@gated-at.bofh.it> <HWvz.5PI.9@gated-at.bofh.it> <I1EP.5QO.1@gated-at.bofh.it> <3F9173FE.5080308@softhome.net> <20031019113743.GO12423@fs.tum.de>
In-Reply-To: <20031019113743.GO12423@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Oct 18, 2003 at 07:10:22PM +0200, Ihar 'Philips' Filipau wrote:
> 
>>Martin J. Bligh wrote:
>>>If you have a puny 128K L2 cache, it might help,
> 
> Martin was ironically talking about people who are ignorant of machines
> with _huge_ caches.
> 

   Oh. Sorry. Probably I need to work on my English bit more.

> I the context of this thread he wanted to vote for making -Os 
> conditionally and not unconditionally enabled by telling that he knows 
> of situations where -O2 produces faster code.

   Absolutely.
   High-end toys, after all, optimized to handle this.

   IMHO this should be settled on per-target basis: embedded system - 
-Os; servers - -O2; desktops - -O3 ;) So instead of CONFIG_EMBEDDED 
better to have CONFIG_TARGET=[desktop|server|embedded].

   Inroducing one more variable into builds - is really painful. I was 
hit by gcc miscompiles and internal errors not once (especially with 
-O[23]). Tracking down this kind of issues would be made more problematic.

P.S. I'm really sorry for my rude response.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

