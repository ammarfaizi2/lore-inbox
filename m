Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUHFWeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUHFWeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUHFWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:34:11 -0400
Received: from hera.kernel.org ([63.209.29.2]:1703 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268204AbUHFWeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:34:08 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
Date: Fri, 6 Aug 2004 22:33:07 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cf10v3$h9l$1@terminus.zytor.com>
References: <20040805200622.GA17324@logos.cnet> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091831587 17718 127.0.0.1 (6 Aug 2004 22:33:07 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 6 Aug 2004 22:33:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040806170931.GA21683@logos.cnet>
By author:    Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In newsgroup: linux.dev.kernel
> > >
> > >Yes correct. *mb() usually imply barrier(). 
> > >
> > >About the flush, each architecture defines its own instruction for doing 
> > >so,
> > > PowerPC has  "sync" and "isync" instructions (to flush the whole cache 
> > > and instruction cache respectively), MIPS has "sync" and so on..
> > 
> > So, there is no platform independent way for doing that in the kernel?
> 
> Not really. x86 doesnt have such an instruction.
> 

Actually it does (sfence, lfence, mfence); they only apply to SSE
loads and stores since all other x86 operations are guaranteed to be
strictly ordered.

	-hpa


