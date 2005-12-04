Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVLDBfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVLDBfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVLDBfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:35:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbVLDBfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:35:04 -0500
Date: Sat, 3 Dec 2005 17:34:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
cc: Greg KH <greg@kroah.com>, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <6f6293f10512031726n10ea87e6s44be5dffbd512bb5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0512031733010.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> 
 <20051201121826.GF19694@charite.de> <20051201211119.GA11437@hygelac> 
 <Pine.LNX.4.64.0512011455090.3099@g5.osdl.org>  <20051202180236.GA19327@hygelac>
 <20051203002224.GB31077@kroah.com> <6f6293f10512031726n10ea87e6s44be5dffbd512bb5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Dec 2005, Felipe Alfaro Solana wrote:
> 
> So, how are we, average end users, supposed to cope with this? What
> implications does this have for us?

Well, the old NVidia module should actually work fine. The VM does a 
number of noisy (and scary) debugging messages, but that's just because 
this area changed a lot, and we do want to know who triggers them. But 
there are at least two reports that seem to be happy with the old module 
just working.

And I actually think I'll just change vm_insert_page() to be a regular 
export. It's not like it does anything really strange, and if the choice 
is between people usign the horrible old interfaces because they don't 
want to use the new one due to that GPL-only, and just making it regular, 
I think I'll make that interface regular.

		Linus
