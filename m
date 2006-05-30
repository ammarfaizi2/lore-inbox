Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWE3Aqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWE3Aqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWE3Aqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 20:46:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751266AbWE3Aqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 20:46:45 -0400
Date: Mon, 29 May 2006 17:46:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: paul@permanentmail.com, git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
In-Reply-To: <20060529225632.7073.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0605291744390.5623@g5.osdl.org>
References: <20060529225632.7073.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 May 2006, linux@horizon.com wrote:
> 
> It's also worth repeating some advice from the manual:
> 
> >> You can further cut down the number of trials if you know what part of
> >> the tree is involved in the problem you are tracking down, by giving
> >> paths parameters when you say bisect start, like this:
> >>
> >> $ git bisect start arch/i386 include/asm-i386

I'm not 100% sure this works - I think it has problems with the ending 
condition because there always ends up being more commits in between when 
the commit space isn't dense, so the "no commits left" thing doesn't 
trigger. But "git bisect visualize" should hopefully help make it obvious

		Linus
