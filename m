Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272147AbTGYPVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272148AbTGYPVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:21:43 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:31682 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S272147AbTGYPVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:21:40 -0400
Message-ID: <3F214EC3.9010804@softhome.net>
Date: Fri, 25 Jul 2003 17:37:39 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
References: <d2nx.4QV.15@gated-at.bofh.it> <dbTZ.5Z5.19@gated-at.bofh.it>
In-Reply-To: <dbTZ.5Z5.19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:

> I believe the point Alan was trying to make is not that we should have 
> more or less inlines, but we should have smarter inlines. I.E. don't 
> just inline a function to "make it fast"; think about the implications 
> (and ideally measure it, though I think that becomes problematic when so 
> many other factors can affect the benefit of a single inlined function). 
> The specific example he gave was inlining code on the fast path, while 
> accepting branch/cache penalties for non-inlined code on the slow path.
> 

   But you cannot make this kind of decisions universal.
   Some kind of compromise should be found between arch-mantainers and 
subsystem-mantainers.

   Or beat GCC developer hard so they finally will produce good
optimizing compiler ;-)

   Or ask all kernel developpers to work one hour per week on GCC 
optimization - I bet GCC will outperform everything else in industry in 
  less that one year ;-)))

   To remind: source of the problem is not inlines, problem is the 
compiler, which cannot read our minds yet and generate code we were 
expected it to generate.

P.S. Offtopic. As I see it Linux & Linus have made the decision of 
optimization. Linux after all is capitalismus creation: who has more 
money do control everything. Server market has more money - they do more 
work on kernel and they systems are not that far from developers' 
workstations - so Linux gets more and more server/workstation oriented. 
This will fit desktop market too - if your computer was made to run 
WinXP AKA exp(bloat) - it will be capable to run any OS. Linus repeating 
'small is beatiful' sounds more and more like crude joke...
As for embedded market - it is already in deep fork and far far away 
from vanilla kernels... Vanilla really not that relevant to real world...

