Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWEYFYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWEYFYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWEYFYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:24:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965027AbWEYFYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:24:39 -0400
Date: Wed, 24 May 2006 22:23:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
 annotations)
Message-Id: <20060524222359.06f467e8.akpm@osdl.org>
In-Reply-To: <4471D691.76E4.0078.0@novell.com>
References: <4471D691.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> wrote:
>
>  #define SAVE_ALL \
>   	cld; \
>   	pushl %es; \
>  +	CFI_ADJUST_CFA_OFFSET 4;\
>  +	/*CFI_REL_OFFSET es, 0;*/\
>   	pushl %ds; \

arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc

etcetera.  And

arch/i386/kernel/entry.S:757: Error: no such instruction: `eax,0'
arch/i386/kernel/entry.S:757: Error: no such instruction: `ebp,0'


bix:/usr/src/25> as --version
GNU assembler 2.14.90.0.6 20030820

