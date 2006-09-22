Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWIVQ3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWIVQ3g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIVQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:29:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18372 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751160AbWIVQ3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:29:34 -0400
Message-ID: <45140F61.4040201@garzik.org>
Date: Fri, 22 Sep 2006 12:29:21 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       Russell King <rmk+kernel@arm.linux.org.uk>
CC: davidsen@tmr.com, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com>
In-Reply-To: <20060922154816.GA15032@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NOTE:  Your mailer generates bogus Mail-Followup-To headers, and you 
snipped rmk from the To/CC.

Dave Jones wrote:
> Hmm. Some trees do seem to get pulled more often than others.
> Linus, is there a upper limit on the number of times you want
> to see pull requests? It strikes me as odd, so I'm wondering
> if there are some crossed wires here.

Not speaking for Linus, but in general it seems like the more pull 
requests you send (within reason), the more pulls that occur.  Russell 
and DaveM certainly seem to send frequent, successful pull requests.


> Has Andrew commented on why this is proving to be more of a problem?
> I've done regular rebases of cpufreq/agpgart (admittedly, they don't
> reject hardly ever unless Len has ACPI bits touching cpufreq) without
> causing too much headache.

Rebasing _inevitably_ causes more headaches than a simple tree update, 
for any downstream consumer of your tree(s).  It is best to avoid wanton 
rebasing.

Think about it:  if someone is pulling and merging your tree, all of a 
sudden, without warning, the entire hash history is rewritten.  So 
rather than a Nice and Friendly minor update, the next time they pull 
your stuff, the downstream user is forced to suffer through either (a) a 
painful merge, or (b) back out your last tree (ugh!) and redo things 
from scratch.

Rebasing might make a pretty history, but it is _not_ fun for random 
consumers of your trees.  It basically punishes people for following 
your tree -- not something you want to do.

	Jeff


