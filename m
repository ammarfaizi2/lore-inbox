Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVA0UA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVA0UA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVA0UAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:00:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:43182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVA0T7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:59:40 -0500
Date: Thu, 27 Jan 2005 11:59:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <1106855326.5624.123.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0501271156500.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
 <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>
  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
  <41F937C0.4050803@comcast.net>  <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
 <1106855326.5624.123.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Btw, since you're clearly at the keyboard now: I do agree with Christoph
that it would be a lot cleaner to just say that all architectures have to
have a arch_align_stack() define, instead of having a
__HAVE_ARCH_ALIGN_STACK define.

After all, a trivial implementation would apparently just be

	#define arch_align_stack(x) (x)

which is not too much of a bother to maintain for an architecture that 
doesn't want to do this ;)

		Linus
