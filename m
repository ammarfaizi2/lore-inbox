Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVKKJjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKKJjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVKKJjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:39:41 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:22357 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbVKKJjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t3ZddyNrUZL44adXKBoAeaBsuR6CT68hQn5LsJTkCac3yuGvba9uwhLBCpSOQQNlWrDMApO9KDyqFGBwNLIy9kWOizUmSoPLU/y1Ahx1VaTzhUhFYW2rPEFBs19o2/Xgthn3L3TcLdCAIF5QhCTNyrEnKKkkNWyD21K0Szyv9BA=
Message-ID: <2cd57c900511110139v221ed3f3m@mail.gmail.com>
Date: Fri, 11 Nov 2005 17:39:39 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 02/02] Debug option to write-protect rodata: the write protect logic and config option
Cc: Josh Boyer <jdub@us.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       akpm@osdl.org
In-Reply-To: <1131373248.2858.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
	 <1131373248.2858.17.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/7, Arjan van de Ven <arjan@infradead.org>:
> On Mon, 2005-11-07 at 08:06 -0600, Josh Boyer wrote:
> > On Mon, 2005-11-07 at 10:58 +0000, arjan@infradead.org wrote:
> > > Hi,
> > >
> > > I've been working on a patch that turns the kernel's .rodata section to be
> > > actually read only, eg any write attempts to it cause a segmentation fault.
> > >
> > > This patch introduces the actual debug option to catch any writes to rodata
> >
> > Why a debug option?  From what I can tell, it doesn't impact runtime
> > performance much and it provides good protection.  Any reason not to
> > make it an always-on feature?
>
> personally I'd like that but there is a chance of a tiny perf regression
> and usually there are people objecting to that.
>
> (It's not clear cut: while the last bit of the kernel no longer is
> covered by a 2Mb tlb, most intel cpus have very few of such tlbs in the
> first place and this would free up one such tlb for other things (say
> the stack data) or even the userspace database), so it's not all that
> clear cut what the cost of this is)

I'm dumb. But how is "the last bit of the kernel no longer is covered
by a 2Mb tlb"? Could you explain a bit more?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
