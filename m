Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWAJUFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWAJUFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWAJUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:05:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21262 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932477AbWAJUFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:05:08 -0500
Date: Tue, 10 Jan 2006 21:04:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-ID: <20060110200447.GC14721@mars.ravnborg.org>
References: <patchbomb.1136579193@eng-12.pathscale.com> <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com> <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com> <1136909276.32183.28.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136909276.32183.28.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:07:56AM -0800, Bryan O'Sullivan wrote:
 
> The only problem with this is that it's an unusual approach, so I don't
> have any obvious examples to copy.  The closest I can think of is
> arch/x86_64/kernel/Makefile, which pulls in routines from the i386 tree
> like this:
> 
>         bootflag-y += ../../i386/kernel/bootflag.o
> 
> So say arch/ia64/lib/Makefile, for example, could have a line like this:
> 
>      obj-y += ../../../lib/raw_memcpy_toio32.o
> 
> Sam, do you think this is safe to do in generalwith respect to kbuild?
It is safe if you pull in .o files from a directory that you otherwise
does not visit. But pulling in .o files that can/will be build
by another Makkefile is doomed.

But seeing other mails in this thread the final solution does not use
this anyway.

	Sam
