Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVBWLsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVBWLsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVBWLsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:48:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:1934 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261465AbVBWLss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:48:48 -0500
Date: Wed, 23 Feb 2005 12:49:27 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
Message-ID: <Pine.LNX.4.62.0502231208470.2948@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
>   material, please tell me.

I guess that depends on how you define 2.6.11 material at this point, but 
I have a few patches that I wrote in there, that I think are potential 
candidates due to them being fairly trivial, obviously correct and not 
having caused any problems since entering -mm. Those patches might as well 
get merged into 2.6.11 now and get out of your queue/hair.


The patches I have in mind are these:

fix-placement-of-static-inline-in-nfsdh.patch
--
This one has no actual impact on the generated code, it just kills a few 
warnings when building with gcc -W, so merging that up should be harmless.

kyrofb-copy__user-return-value-checks-added-to-kyro-fb.patch
--
This one just adds a few return value checks to copy_*_user calls and 
returns -EFAULT when failing. I've seen no complains about the patch on 
the list and it seems to be the obviously correct thing to do - might as 
well get merged.

warning-fix-in-drivers-cdrom-mcdc.patch
--
Trivial, obviously correct, warning fix to an ancient driver. No point in 
having you carry it around in -mm, let's just merge it.

make-loglevels-in-init-mainc-a-little-more-sane.patch
--
This one just changes a few loglevels, so the potential for breakage is 
extremely low. Besides I believe I've argued the case for the new 
loglevels being more sane than the old ones well enough, and noone has 
complained about the patch.


The patches above are all very low risk, so they shouldn't cause any 
problems for 2.6.11. Let us merge them now to a) get the bennefit of them 
in 2.6.11 and b) get them out of your -mm queue.


nitpick note: despite some of these patches having From: lines in them in 
your -mm patch set that list other people they where all written by me. 
Other people getting listed as From: (and thus later as patch author in 
the changelogs and bk) seems to happen when other people resend the 
patches to the list or when they pass through maintainers before they 
reach you. Just to set the record straight; I initially wrote the patches 
above.


Kind regards,

Jesper Juhl <juhl-lkml@dif.dk>


