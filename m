Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVLLOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVLLOqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVLLOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:46:00 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:15366 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751089AbVLLOp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:45:59 -0500
In-Reply-To: <20051203135608.GJ31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <671576E7-A7F1-4FF9-8E4B-361A89ADA173@oxley.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 12 Dec 2005 14:45:52 +0000
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Dec 2005, at 13:56, Adrian Bunk wrote:

> The current kernel development model is pretty good for people who
> always want to use or offer their costumers the maximum amount of the
> latest bugs^Wfeatures without having to resort on additional  
> patches for
> them.
>
> Problems of the current development model from a user's point of view
> are:
> - many regressions in every new release
> - kernel updates often require updates for the kernel-related  
> userspace
>   (e.g. for udev or the pcmcia tools switch)
>
> One problem following from this is that people continue to use older
> kernels with known security holes because the amount of work for  
> kernel
> upgrades is too high.
>
> These problems follow from the development model.
>
> The latest stable kernel series without these problems is 2.4, but 2.4
> is becoming more and more obsolete and might e.g. lack driver support
> for some recent hardware you want to use.
>
> Since Andrew and Linus do AFAIK not plan to change the development
> model, what about the following for getting a stable kernel series
> without leaving the current development model:
>
>
> Kernel 2.6.16 will be the base for a stable series.
>
> After 2.6.16, there will be a 2.6.16.y series with the usual stable
> rules.
>
> After the release of 2.6.17, this 2.6.16.y series will be continued  
> with
> more relaxed rules similar to the rules in kernel 2.4 since the  
> release
> of kernel 2.6.0 (e.g. driver updates will be allowed).
>
>
> Q:
> What is the target audience for this 2.6.16 series?
>
> A:
> The target audience are users still using 2.4 (or who'd still use  
> kernel
> 2.4 if they weren't forced to upgrade to 2.6 for some reason) who  
> want a
> stable kernel series including security fixes but excluding many
> regressions.
> It might also be interesting for distributions that prefer stability
> over always using the latest stuff.
>
>
> Q:
> Does this proposal imply anything for the development between  
> 2.6.15 and
> 2.6.16?
>
> A:
> In theory not.
> In practice, it would be a big advantage if some of the bigger
> changes that might go into 2.6.16 would be postponed to 2.6.17.
>
>
> Q:
> Why not start with the more relaxed rules before the release of  
> 2.6.17?
>
> A:
> After 2.6.16.y following the usual stable rules, the kernel should be
> relatively stable and well-tested giving the best possible basis for a
> long-living series.
>
>
> Q:
> How long should this 2.6.16 series be maintained?
>
> A:
> Time will tell, but if people use it I'd expect 2 or 3 years.
>
>
> Q:
> Stable API/ABI for external modules?
>
> A:
> No.
>
>
> Q:
> Who will maintain this branch?
>
> A:
> I could do it, but if someone more experienced wants to do it that  
> would
> be even better.
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


What if ...

1. When people make a patch set, if they have encountered any 'bugs'  
they split them out as separate items.

2. The submitter would identify through GIT when the error had been  
introduced so that the the person responsible could be CC'ed, also  
anybody who had worked on the code recently would be CCed, therefore  
the programmers who were most familiar with that section of code  
would be made aware of it.

3. When the patch is posted to LKML, it is tagged [PATCH][FIX] in the  
subject line.
     In the body of the fix would be noted each kernel to which the  
fix applied e.g [FIX 2.6.11][FIX 2.6.12][FIX 2.6.13][FIX 2.6.14]

4. The programmers mentioned in (2) would ACK the patch which would  
then become part of an 'official' fixes list.

5. If a volunteer wanted to maintain, say, 2.6.14 + fixes, they could  
build and test it and be a point of contact regarding any problems.  
These could hopefully be tracked down and submitted as a new fix patch.

regards,
Felix


