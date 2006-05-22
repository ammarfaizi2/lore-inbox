Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWEVRqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWEVRqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWEVRqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:46:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbWEVRqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:46:52 -0400
Date: Mon, 22 May 2006 10:46:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       jakub@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
In-Reply-To: <20060522172710.GA22823@elte.hu>
Message-ID: <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
 <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain>
 <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com>
 <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org>
 <20060522172710.GA22823@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 May 2006, Ingo Molnar wrote:
>
> very much so. Especially for security it's really bad if a feature is 
> default-off. I'm quite strongly against such an approach.

It's not bad at all.

It's default-off FOR THE KERNEL.

Make Fedora updates (and RHEL) just turn it on in the rc scripts. So that 
it's default ON for those, WHEN IT WORKS.

> is it really a big problem to add "vdso=0" to the long list of 
> requirements you need to run a 2.6 kernel on an old distribution (or to 
> disable CONFIG_VDSO)? FC1 wasnt even 2.6-ready, it used a 2.4 kernel!

Backwards compatibility is absolutely paramount. Much more important than 
just about anything else.

		Linus
