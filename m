Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263431AbUJ2RR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbUJ2RR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbUJ2RIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:08:40 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:32535 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263386AbUJ2REy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:04:54 -0400
Date: Fri, 29 Oct 2004 21:05:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: i386: use generic support for offsets.h
Message-ID: <20041029190526.GA8246@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190221.GD9004@mars.ravnborg.org> <20041029095214.GM11105@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029095214.GM11105@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:52:14AM +0200, Jan-Benedict Glaw wrote:
> On Thu, 2004-10-28 21:02:21 +0200, Sam Ravnborg <sam@ravnborg.org>
> wrote in message <20041028190221.GD9004@mars.ravnborg.org>:
> > diff -Nru a/include/asm-i386/offsets.c b/include/asm-i386/offsets.c
> > --- /dev/null	Wed Dec 31 16:00:00 196900
> > +++ b/include/asm-i386/offsets.c	2004-10-28 20:47:38 +02:00
> > @@ -0,0 +1,66 @@
> 
> To be honest, I don't really like to have .c files in the include
> pathes... However, I don't know about a better idea (except maybe to
> place this into ./linux/arch/$(ARCH)/lib/)...

Having the source file in same directory as the result file is a
pattern used all over the kernel. Moving the .c file to include/asm-xxx
just made this true for offsets.h.
In this process a renaming took place so the name of the source file
and the result file match except for the extension.

Some architectures had: asm_offsets.c => offsets.h
A non-logical renaming.

As for the idea of having source file located in a separate
directory. It's not supported by kbuild today, and I'm reluctant
to support it - since it usually triggers misuse.
kbuild is about making the trivial stuff easy, but not about full
flexibility. If we wanted full flexibility we would not have used
so much effort to define a simple syntax.

	Sam
