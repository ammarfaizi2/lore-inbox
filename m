Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWEVTl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEVTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWEVTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:41:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWEVTlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:41:25 -0400
Date: Mon, 22 May 2006 12:40:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       jakub@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
In-Reply-To: <20060522190947.GA6730@elte.hu>
Message-ID: <Pine.LNX.4.64.0605221239100.3697@g5.osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
 <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain>
 <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com>
 <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org>
 <20060522172710.GA22823@elte.hu> <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
 <20060522190947.GA6730@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 May 2006, Ingo Molnar wrote:
> 
> But wrt. binary compatibility, the vdso (ignoring for a moment that it's 
> tied to other parts of glibc) is kind of border line. Nothing but glibc 
> knows about its internal structure. So i dont think "binary 
> compatibility" per se is violated: no app breaks. This is more analogous 
> to the situation where say old modutils cannot read new modules and the 
> kernel wont boot at all.

No it's not. 

This is totally different from a 2.4.x -> 2.6.x breakage. This is about a 
kernel that used to work (2.6.16) and one that would not (2.6.17).

It's _that_ simple. No ifs, buts, maybe's or anything else.

			Linus
