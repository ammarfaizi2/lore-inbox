Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSFIR7a>; Sun, 9 Jun 2002 13:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSFIR72>; Sun, 9 Jun 2002 13:59:28 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1186 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314277AbSFIR6c>;
	Sun, 9 Jun 2002 13:58:32 -0400
Date: Sun, 2 Jun 2002 15:52:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, lord@sgi.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, bcrl@redhat.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020602155202.F219@toy.ucw.cz>
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com> <20020605183152.H4697@redhat.com> <20020605.161342.71552259.davem@redhat.com> <m3d6v5mcm2.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The scenario Steve outlined was rather optimistic - more pessimistic
> case would be e.g:
> you run NBD which calls the network stack with an complex file system on top
> of it called by something else complex that does a GFP_KERNEL alloc and VM 
> wants to flush a page via the NBD file system - 

Actually, at this point we are dead anyway because of locks in NBD. NBD should
be carefull to use GFP_NOIO.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

