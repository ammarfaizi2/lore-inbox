Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJAViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJAViV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUJAVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:37:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54710 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266704AbUJAVgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:36:39 -0400
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041001120926.4d6f58d5.akpm@osdl.org>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001120926.4d6f58d5.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 14:29:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 12:09, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I randomly see "ps" hangs on my AMD64 system running 2.6.9-rc2-mm4.
> >  I don't remember seeing this on earlier kernels. Is this something
> >  known/fixed ?
> 
> hm.  I can see that access_process_vm() is doing lock_page() inside
> mmap_sem, which is a ranking bug, but it's not that.
> 
> And I see a distinct lack of flush_foo_page() calls after the by-hand
> modification of the user page.  But it's not that either.
> 
> Can you work out who is holding mmap_sem for writing?
> 

grr.. okay. It hangs randomly. Don't we have code to record the holder
of a sem somewhere ?

Thanks,
Badari

