Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWKUPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWKUPIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030812AbWKUPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:08:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:8164 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030561AbWKUPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:08:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=k5bH4rDORRm7nhHAFmqj+N6HhAD6n0UaHnxx7Q5DBR9Hjtaosd4d1B0hOndX764XdUtB5o9o+RNK6dEPQ7b+VMvWMce3wNwsDasul1aHtHV4VMBfjnrkRn/Q2Vf1ExgCVl7Y4WYgK3b+tzHLuHz7p+FxLY2taauRvS1RoEPD/Ic=
Date: Tue, 21 Nov 2006 17:08:46 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1697835939.20061121170846@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
CC: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Jiri Slaby <jirislaby@gmail.com>, <linux-kernel@vger.kernel.org>,
       <kernel-discuss@handhelds.org>
Subject: Re[2]: Where did find_bus() go in 2.6.18?
In-Reply-To: <20061120173550.GV31879@stusta.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com> <20061120173550.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

Monday, November 20, 2006, 7:35:50 PM, you wrote:

[]

>>   And suddenly - oops, in 2.6.18 we lose ability to query the highest
>> level of hierarchy, namely bus set.

[]

> As Documentation/stable_api_nonsense.txt explains, there is no stable 
> kernel API.

  Thanks, Adrian, from the first mail I really counted which reply #
(if I would get them at all) will point me to that "bible" of kernel
developers, and just wondered, would it be too ugly to ask for an answer
which wouldn't recourse to that doc.

  But now that you mentioned it, let me make you laugh at jaundiced
eye's look on the issue: it appears it's just itch for kernel
developers to make APIs not stable. When some API is stable, because
it's both trivial and complete (like that bus methods which are just
based on generic container object idea - you can't add or take from
that), some artificial criteria are employed, like "unused", to still
find a way to destabilize API ;-).

> If you don't want to get the APIs your driver uses 
> changed/removed you should really try to get it merged into mainline.

  Would this really be the case? I guess, most people would think that
getting something into mainline is indeed the end of battle. And yet
for others, it may be the case that single driver using some API is
almost just the same as 0 drivers doing that. If 1001 is almost 1000,
why 1 can't be almost 0? Why this would be worse than "Well, noone
uses that call now - let's make noone use it ever, at all."

  So that's what I'm trying to argue - let the change which needs to
be done, be based on the high-level ideas of the meaning of the thing
being changed, not on purely quantitative, and thus, subject to
separate interpretation, parameters.

  And removing a method from an integral, high-level API set is not the
same as killing static variable in a hardware driver.

> The find_bus() case is even more interesting since you are using it in a
> driver although it has never been exported to modules. Considering that
> you anyway have to patch the kernel for getting your driver running 
> (since it won't run as a module against an unmodified kernel), you could
> simply undo my patch locally until you submit your driver for inclusion
> in mainline.

  Well, I believe you expected and cared to get such feedback, because
otherwise, you wouldn't use #if 0, but killed unlucky function
completely ;-(. I don't hold breath for those #if 0 to be removed
based on the above right now, but I hope the function at least won't
be removed completely for now, to indeed let whoever may have need for
it still use it somehow (and submit code to mainline, if that is what
actually would take to have the issue resolved).

  As for EXPORT's, indeed, mainline kernel lacks quite a few
which are useful. But obviously, I won't argue for adding them now,
out of context - that would be just as random change, as, IMHO, and
sorry, removing find_bus() from use.

>>  Paul

> cu
> Adrian




-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

