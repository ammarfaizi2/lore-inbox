Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUBBPjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUBBPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:39:21 -0500
Received: from nevyn.them.org ([66.93.172.17]:16256 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265669AbUBBPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:39:20 -0500
Date: Mon, 2 Feb 2004 10:39:19 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3 broke ptrace in the vsyscall dso area
Message-ID: <20040202153918.GA1935@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20040202035508.GA10286@nevyn.them.org> <200402020543.i125hgoa009640@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402020543.i125hgoa009640@magilla.sf.frob.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 09:43:42PM -0800, Roland McGrath wrote:
> > Any idea what might have disabled this?
> 
> ...Mosberger!!  When Andrew asked me to sign off on David's rework of that
> code, I did so with the caveat that it be tested on i386 before being
> accepted, and evidently it never was.
> 
> The #include is the part of this patch that matters, so the #ifdef below
> works.  (Frankly, I have never seen the rationale for conditionalizing this
> code on AT_SYSINFO_EHDR rather than just FIXADDR_USER_START.  But David
> wanted it that way and Andrew approved it.)  The rest of the patch removes
> gratuitous duplication due to some strange aversion to concision in the
> presence of #ifdef, the kind that is all too common, utterly pointless, and
> error prone.

Thanks, adding <linux/elf.h> makes GDB much happier.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
