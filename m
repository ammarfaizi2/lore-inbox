Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVHETTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVHETTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVHETTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:19:22 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:34137 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262823AbVHETSk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:18:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FLNTEDKNMGh2GXuayAgpbvuC6BWLt4Ihegmd7cAHP4a1zWn+qJw8JbWITaL3pdb5h7S6B/Ym0sv8JaPk/ih7LVMpMf6kr3qmtnYOYI5rIggmHOs7ZTo/eMXA3hgNoxlVfU6+9Zbbd0A5Pk9qBch+HT3EgGs9Tv8/5UyQ9zmB+4A=
Message-ID: <40f323d00508051218c30d7af@mail.gmail.com>
Date: Fri, 5 Aug 2005 21:18:38 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
In-Reply-To: <20050805190006.GA6747@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050708150313.GA30373@suse.de>
	 <40f323d005080511516a81a7d6@mail.gmail.com>
	 <20050805190006.GA6747@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Olaf Hering <olh@suse.de> wrote:
>  On Fri, Aug 05, Benoit Boissinot wrote:
> 
> > On 7/8/05, Olaf Hering <olh@suse.de> wrote:
> > >
> > > In file included from include2/asm/tlb.h:31,
> > >                  from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
> > > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'
> > >
> > This went in 2.6.13-rc3 (commit
> > 542d1c88bd7f73e2e59d41b12e4a9041deea89e4), and broke sparc compilation
> > because of the following circular dependency:
> > asm-sparc/pgtable include linux/swap.h
> 
> Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
> 
sparc is the only architecture to do that, it looks like it uses it
for boot time linking (BTFIXUP_*). I don't know anything about sparc,
so i can't fix it.

(adding sparclinux@vger.kernel.org to the cc list)
