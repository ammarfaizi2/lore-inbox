Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269864AbUJHLrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269864AbUJHLrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269866AbUJHLrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:47:35 -0400
Received: from zero.aec.at ([193.170.194.10]:37135 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269864AbUJHLra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:47:30 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, khawar.chaudhry@amd.com,
       reeja.john@amd.com
Subject: Re: [PATCH] amd8111e endian & barrier fixes
References: <2MWTy-5mO-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 08 Oct 2004 13:47:18 +0200
In-Reply-To: <2MWTy-5mO-5@gated-at.bofh.it> (Benjamin Herrenschmidt's
 message of "Fri, 08 Oct 2004 09:00:12 +0200")
Message-ID: <m3u0t5a0u1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hi Jeff !
>
> This patch against the amd8111e makes it work on some about-to-be-released
> piece of PPC hardware. It does:
>
>  - Fix endian
>  - Search for the PHY on MII instead of hard coding the ID
>  - Add a couple of wmb's where needed on descriptor updates
>
> I must appologize for having re-indented one of the rx functions, but I
> just couldn't read/understand it without doing so, it was going back
> leftward in the middle of a { } block ...

It's basically impossible to review the patch properly because
of that change. Can you please separate the arbitary white space
change into a different patch? 

Also I would suggest you send the patch to the driver 
maintainers for review first (cc'ed) 

>From a quick look the change to clear the ring rx flags completely
instead of clearing the bit looks bogus. Why did you not just add a
endian conversion there?

I can test it when it's properly reviewd.

-Andi

