Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUATR47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUATR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:56:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:10454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265640AbUATR44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:56:56 -0500
Date: Tue, 20 Jan 2004 09:56:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: der.eremit@email.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
In-Reply-To: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0401200953470.2123@home.osdl.org>
References: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jan 2004 Andries.Brouwer@cwi.nl wrote:
> 
>     If Andries wants to
>     re-send the whitespace fixes, I can apply those too, but I hate applying 
>     patches like this where the whitespace fixes hide the real fix.
> 
> Yes, it seems we presently have no good mechanism / policy here.
> Patches are noise. If some kernel version works and another doesnt,
> one has to look at the diffs. Whitespace-only diffs are bad,
> I would never submit them. They also needlessly invalidate existing patches.

Whitespace-only diffs can be very useful. In particular, they are common 
when somebody starts working on a piece of code without a maintainer, and 
the old code was terminally broken wrt whitespace. Happens quite often in 
the driver world.

So I don't have any real issues with applying whitespace-only patches, and 
I much prefer them to patches that mix whitespace and bugfixes. In 
particular, if the whitespace fixes are preparation for some other 
cleanup, it's usually a good idea.

(I agree that if the whitespace fix is just random, it's usually not worth 
it).

		Linus
