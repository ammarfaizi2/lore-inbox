Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVA0UJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVA0UJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVA0UHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:07:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15630 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261153AbVA0UEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:04:33 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.58.0501271156500.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F937C0.4050803@comcast.net>
	 <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
	 <1106855326.5624.123.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501271156500.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 21:04:21 +0100
Message-Id: <1106856262.5624.130.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 11:59 -0800, Linus Torvalds wrote:
> 
> Btw, since you're clearly at the keyboard now: I do agree with Christoph
> that it would be a lot cleaner to just say that all architectures have to
> have a arch_align_stack() define, instead of having a
> __HAVE_ARCH_ALIGN_STACK define.
> 
> After all, a trivial implementation would apparently just be
> 
> 	#define arch_align_stack(x) (x)
> 
> which is not too much of a bother to maintain for an architecture that 
> doesn't want to do this ;)

yes I will make this change and post it a bit later
(I want to at least test compile it for a few)


