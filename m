Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCBXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCBXDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCBW76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:59:58 -0500
Received: from c-67-177-11-57.client.comcast.net ([67.177.11.57]:1664 "EHLO
	vger") by vger.kernel.org with ESMTP id S261222AbVCBW4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:56:32 -0500
Message-ID: <422643F0.8050603@utah-nac.org>
Date: Wed, 02 Mar 2005 15:53:36 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__Stable__ would be a good thing. The entire 2.6 development has been a 
disaster from
a stability viewpoint. I have to maintain a huge tree of patches in 
order to ship appliance
builds due to the lack of stability for 2.6. I think that the even 
number releases will take longer
but it's worth the wait.

Jeff

Linus Torvalds wrote:

>This is an idea that has been brewing for some time: Andrew has mentioned
>it a couple of times, I've talked to some people about it, and today Davem
>sent a suggestion along similar lines to me for 2.6.12.
>
>Namely that we could adopt the even/odd numbering scheme that we used to 
>do on a minor number basis, and instead of dropping it entirely like we 
>did, we could have just moved it to the release number, as an indication 
>of what was the intent of the release.
>
>The problem with major development trees like 2.4.x vs 2.5.x was that the 
>release cycles were too long, and that people hated the back- and 
>forward-porting. That said, it did serve a purpose - people kind of knew 
>where they stood, even though we always ended up having to have big 
>changes in the stable tree too, just to keep up with a changing landscape.
>
>So the suggestion on the table would be to go back to even/odd, but do it 
>at the "micro-level" of single releases, rather than make it a two- or 
>three-year release cycle.
>
>In this setup, all kernels would still be _stable_, in the sense that we
>don't anticipate any real breakage (if we end up having to rip up so much
>basic stuff that we have to break anything, we'd go back to the 2.7.x kind
>of numbering scheme). So we should fear odd releases, but track them, to 
>make sure that they are good (if you don't track them, and problems won't 
>be fixed in the even version either)
>
>But we'd basically have stricter concerns for an even release, and in
>particular the plan would be that the diff files would alternate between
>bigger ones (the 2.6.10->11 full diff was almost 5MB) and smaller ones (a
>2.6.11->12 release would be a "stability only" thing, and hopefully the
>diff file would be much smaller).
>
>We'd still do the -rcX candidates as we go along in either case, so as a 
>user you wouldn't even _need_ to know, but the numbering would be a rough 
>guide to intentions. Ie I'd expect that distributions would always try to 
>base their stuff off a 2.6.<even> release.
>
>It seems like a sensible approach, and it's not like the 2.4.x vs 2.5.x
>kind of even/odd thing didn't _work_, the problems really were an issue of
>too big granularity making it hard for user and developers alike. So I see
>this as a tweak of the "let's drop the notion althogether for now"  
>decision, and just modify it to "even/odd is meaningful at all levels".
>
>In other words, we'd have an increasing level of instability with an odd 
>release number, depending on how long-term the instability is.
>
> - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
>   patches leading up to it (timeframe: a week or two)
>
>with the odd numbers going like:
>
> - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>   to it (timeframe: a month or two).
> - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
>   several releases (timeframe: a year or two)
> - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>   the kernel to be a microkernel using a special message-passing version 
>   of Visual Basic. (timeframe: "we expect that he will be released from 
>   the mental institution in a decade or two").
>
>The reason I put a shorter timeframe on the "all-even" kernel is because I
>don't want developers to be too itchy and sitting on stuff for too long if
>they did something slightly bigger. In theory, the longer the better
>there, but in practice this release numbering is still nothing but a hint
>of the _intent_ of the developers - it's still not a guarantee of "we
>fixed all bugs", and anybody who expects that (and tries to avoid all odd 
>release entirely) is just setting himself up for not testing - and thus 
>bugs.
>
>Comments?
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

