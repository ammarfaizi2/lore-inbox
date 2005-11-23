Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVKWTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVKWTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKWTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:43:09 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:38578 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932248AbVKWTnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:43:07 -0500
Date: Wed, 23 Nov 2005 12:31:44 -0700
From: jmerkey@ns1.utah-nac.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123193144.GB19557@ns1.utah-nac.org>
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <4384A63E.6030706@wolfmountaingroup.com> <Pine.LNX.4.64.0511231059450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231059450.13959@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:03:15AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Nov 2005, Jeff V. Merkey wrote:
> >
> > The lock prefix '0F' is used for a lot of opcodes other than "lock". Go check
> > the instruction set reference.
> 
> No it's not.
> 
> 0F is indeed the two-byte prefix. But lock is F0, and it's unique.
> 
> Sometimes Intel re-uses the prefixes for other things eg "rep nop", but I 
> don't think that has ever happened for the lock prefix. 
> 
> Besides, the instructions look very different internally in the CPU after 
> decoding, and anyway you'd not want to ignore the lock prefix _early_ at 
> decode time anyway (many instructions turn into illegal instructions with 
> a lock prefix, as do reg-reg modrm bytes). So you'd dismiss the lock 
> prefix not at a byte level, but at a minimum just after the decode stage.
> 
> 		Linus

I always get numbers and words transposed.  Thanks for the correction. 

J
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
