Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUBLScw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUBLScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:32:52 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:19638 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S266524AbUBLScu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:32:50 -0500
Date: Thu, 12 Feb 2004 11:32:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040212183247.GR19676@smtp.west.cox.net>
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel> <p73wu6syf0n.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wu6syf0n.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 07:43:04AM +0100, Andi Kleen wrote:

> Tom Rini <trini@kernel.crashing.org> writes:
[snip]
> > --- a/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> > +++ b/include/asm-x86_64/processor.h	Wed Feb 11 15:42:06 2004
> > @@ -252,6 +252,7 @@
> >  	unsigned long	*io_bitmap_ptr;
> >  /* cached TLS descriptors. */
> >  	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
> > +	void		*debuggerinfo;
> >  };
> 
> This should not be needed

OK.  Unless there is a difference in this respect on i386 vs x86_64 in
2.6.3-rc2-mm1, this is needed for the thread support which is in this
version, but not the -mm version.  OTOH, if there is a cleaner way of
doing this, and there indeed might be (I need to sit down and re-read
some of the previous threads), I'm all ears, not tied to doing it that
way, etc, etc.

-- 
Tom Rini
http://gate.crashing.org/~trini/
