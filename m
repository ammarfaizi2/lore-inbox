Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWEZP3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWEZP3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWEZP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:29:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbWEZP3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:29:21 -0400
Date: Fri, 26 May 2006 08:28:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: mingo@elte.hu, ak@suse.de, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
 annotations)
Message-Id: <20060526082828.58d7d752.akpm@osdl.org>
In-Reply-To: <4476C9B9.76E4.0078.0@novell.com>
References: <4471D691.76E4.0078.0@novell.com>
	<20060524222359.06f467e8.akpm@osdl.org>
	<4476C9B9.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> wrote:
>
> >>> Andrew Morton <akpm@osdl.org> 25.05.06 07:23 >>>
> >"Jan Beulich" <jbeulich@novell.com> wrote:
> >>
> >>  #define SAVE_ALL \
> >>   	cld; \
> >>   	pushl %es; \
> >>  +	CFI_ADJUST_CFA_OFFSET 4;\
> >>  +	/*CFI_REL_OFFSET es, 0;*/\
> >>   	pushl %ds; \
> >
> >arch/i386/kernel/entry.S: Assembler messages:
> >arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> >arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> >arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> >arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> >arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> >arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> >arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> >
> >etcetera.  And
> >
> >arch/i386/kernel/entry.S:757: Error: no such instruction: `eax,0'
> >arch/i386/kernel/entry.S:757: Error: no such instruction: `ebp,0'
> >
> >
> >bix:/usr/src/25> as --version
> >GNU assembler 2.14.90.0.6 20030820
> 
> Still doesn't make sense to me, assuming the merge didn't corrupt anything. The oldest assembler I'm using is
> 2.15.90.0.1.1, but as said before your assembler clearly also supports .cfi_*. Any chance I could see the offending
> entry.S?
> 

http://www.zip.com.au/~akpm/linux/patches/stuff/entry.S
