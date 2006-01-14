Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWANODJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWANODJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWANODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:03:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48909 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751290AbWANODH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:03:07 -0500
Date: Sat, 14 Jan 2006 15:03:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Message-ID: <20060114140301.GA8443@mars.ravnborg.org>
References: <4370AF4A.76F0.0078.0@novell.com> <20060114045635.1462fb9e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114045635.1462fb9e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 04:56:35AM -0800, Andrew Morton wrote:
> 
> > Index: linux/Makefile
> > ===================================================================
> > --- linux.orig/Makefile
> > +++ linux/Makefile
> > @@ -502,6 +502,10 @@ CFLAGS		+= $(call add-align,CONFIG_CC_AL
> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
> >  
> > +ifdef CONFIG_UNWIND_INFO
> > +CFLAGS		+= -fasynchronous-unwind-tables
> > +endif
Is this option available on all gcc's for all archs?
Otherwise you have to do:
CFLAGS		+= $(call cc-option,-fasynchronous-unwind-tables,)

	Sam
