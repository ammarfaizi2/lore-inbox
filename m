Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWJFLUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJFLUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWJFLUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:20:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37020 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750784AbWJFLUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:20:10 -0400
Subject: Re: Really good idea to allow mmap(0, FIXED)?
From: Arjan van de Ven <arjan@infradead.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <17702.12704.868782.312125@alkaid.it.uu.se>
References: <200610052059.11714.mb@bu3sch.de>
	 <eg4624$be$1@taverner.cs.berkeley.edu>
	 <1160119515.3000.89.camel@laptopd505.fenrus.org>
	 <17702.12704.868782.312125@alkaid.it.uu.se>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 06 Oct 2006 13:20:05 +0200
Message-Id: <1160133606.3000.101.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 12:36 +0200, Mikael Pettersson wrote:
> Arjan van de Ven writes:
>  > >     mmap(0, 4096, PROT_READ|PROT_EXEC|PROT_WRITE,
>  > >         MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>  > >     struct s *bar = 0;
>  > 
>  > the question isn't if it's a good idea to allow mmap(0) but to allow
>  > mmap PROT_WRITE | PROT_EXEC !
> 
> It is if you want JITs, code loaders, virtualisation engines, etc
> to continue working.

yeah I know we can't forbid it point blank
(having said that, on architectures where I and D cache aren't coherent
(and there are many, including ia64), most of these are buggy anyway;
the sane ones actually do an mprotect between writing and executing, so
that the kernel can take care of the cache coherency properly)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

