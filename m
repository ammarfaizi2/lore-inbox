Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDHCCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDHCCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:02:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:8866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbUDHCBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:01:40 -0400
Date: Wed, 7 Apr 2004 19:01:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ak@suse.de, david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       anton@samba.org, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407190126.06a9c38f.akpm@osdl.org>
In-Reply-To: <1081386710.1401.86.camel@gaston>
References: <20040407074239.GG18264@zax>
	<20040407143447.4d8f08af.ak@suse.de>
	<1081386710.1401.86.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > Implementing this for ppc64 only is just wrong. Before you do this 
> > I would suggest to factor out the common code in the various hugetlbpage
> > implementations and then implement it in common code.
> 
> Have you actually looked at it and how huge pages are implemented
> on the various architectures ?
> 
> Honestly, I don't think we have any common abstraction on things
> like hugepte's etc... actually, archs aren't even required to use
> PTEs at all.
> 
> I don't see how we can make that code arch-neutral, at least not
> without a major redesign of the whole large pages mecanism.

I don't see much in the COW code which is ppc64-specific.  All the hardware
needs to do is to provide a way to make the big pages readonly.  With a bit
of an abstraction for the TLB manipulation in there it should be pretty
straightforward.

Certainly worth the attempt, no?
