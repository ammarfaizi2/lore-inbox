Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVKWTmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVKWTmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKWTmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:42:05 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:36530 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932243AbVKWTmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:42:02 -0500
Date: Wed, 23 Nov 2005 12:30:33 -0700
From: jmerkey@ns1.utah-nac.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
Message-ID: <20051123193033.GA19557@ns1.utah-nac.org>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <4384BF01.4020605@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384BF01.4020605@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:12:01AM -0800, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> >
> >Of course, if it's in one of the low 12 bits of %cr3, there would have to 
> >be a "enable this bit" in %cr4 or something. Historically, you could write 
> >any crap in the low bits, I think.
> >
> 
> No, most of them are RAZ, but there are at least a couple of bits which 
> have effect (e.g. caching of the page tables.)
> 
> However, with PAE there aren't really a whole lot of unused bits in CR3.
> 
> 	-hpa
> -

Changing CR3 will break compatibility with Windows and interfere with Intel's Bread and Butter gravy Train with M$.  CR4 was created to deal with some of the
legacy issues with backward compatiblity with OS's that read CR3.  Messing with CR3 will break Windows.

They won't do anything that will upset the apple cart with M$.  I dealt with
Intel folks for years when Linux was unknown.  They look and act like boy scouts-- don't be fooled -- they're totally an M$ shop, always have been, always will be.  Linux was and is an intresting brain fart on their radar.  Their interests in it are solely based on their internal "Rabbits and Dogs" Andy Grove mentality.  They say there are rabbits and dogs.  Rabbits run out front, dogs chase the rabbits.  Intel does business with rabbits.  Linux is a dog -- it chases after innovators and replicates their work.  The fact it's free is the basis of their interest.

Those interests do not extend to anything that interferes with their M$ relationship.  Push for CR4, they might agree, but be assured your request will pass Balmers desk before it gets approved.

J
