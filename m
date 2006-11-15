Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966627AbWKOBzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966627AbWKOBzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966626AbWKOBzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:55:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966627AbWKOBzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:55:32 -0500
Date: Tue, 14 Nov 2006 17:55:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <455A6EBF.7060200@garzik.org>
Message-ID: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
References: <200611150059.kAF0xBTl009796@hera.kernel.org> <455A6EBF.7060200@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Jeff Garzik wrote:
> 
> :(  Like AHCI, PCI MSI has -always- worked wonderfully for HD audio AFAIK.

That "AFAIK" is shorthand for "As Far As I haven't read any of the 
bug-reports but Know", right?

> Is a whitelist patch forthcoming?

Probably not. The advantages of MSI aren't all that obvious, and the 
disadvantages seem to be that it just doesn't work all that well for some 
people.

The fact that it works for MOST people has absolutely zero relevance. 
We've had too many frigging patches that have apparently been of the "this 
works for me, I don't care if some other motherboard has problems" kind.

See for example:

	http://lkml.org/lkml/2006/10/7/164

and yes, that HDA MSI _does_ seem to be causing problems.

So don't blather about "MSI never causes problems". It's broken. Please 
stop living in denial.

When somebody can actually say what the huge advantages to MSI are that 
it's worth using when 

 (a) several motherboards are apparently known broken

 (b) microsoft apparently is of the same opinion and _also_ doesn't use it

 (c) the old non-MSI code works fine

 (d) there is apparently no fool-proof way to tell when it works and when 
     it doesn't.

then please holler. Btw, I'm not even _interested_ in any advantages 
unless you also have a solution for (d). Not a "it should work". I want to 
hear something that is _guaranteed_ to work.

Until that point, I will suggest that we always just disable MSI by 
default, and people who want to use it need to enable it BY HAND.

F*ck whitelists. It's better and easier to just NOT USE IT! There are 
basically zero advantages to using MSI anyway, until you get to big enough 
systems that you have a system maintainer that can make the decision.

			Linus
