Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266092AbUFPDLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbUFPDLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUFPDIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:08:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:19842 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266092AbUFPDEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:04:34 -0400
Date: Tue, 15 Jun 2004 20:04:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, mika@osdl.org
Subject: Re: [PATCH] security_sk_free void return fixup
In-Reply-To: <20040615200003.0100392a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0406152002500.4142@ppc970.osdl.org>
References: <20040615161646.S21045@build.pdx.osdl.net>
 <Pine.LNX.4.58.0406151946220.4142@ppc970.osdl.org> <20040615200003.0100392a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jun 2004, Andrew Morton wrote:
> > 
> > I'm going to remove this warning from sparse. Apparently it is valid C99, 
> 
> yes, but in every(?) case where it triggered, the kernel code was wrong.

Is that true? Hmm. That would indeed be a strong argument. However, I was 
also a bit alarmed by how one of the fixes for this warning was itself 
actually buggy by dropping the "return" statement altogether and falling 
through. 
 
> So I'd suggest the warning be retained, perhaps with an option to enable
> it.

Hmm. Sparse already has a "verbose" level, although right now it's not 
actually used by anything (it used to enable some warnings that were due 
to sparse deficiencies, but I fixed that particular problem).

		Linus
