Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVA0VTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVA0VTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVA0VTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:19:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:21990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbVA0VN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:13:56 -0500
Date: Thu, 27 Jan 2005 13:13:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <1106859409.5624.140.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0501271312440.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
 <20050127202335.GA2033@infradead.org>  <20050127202720.GA12390@infradead.org>
  <20050127203206.GA2180@infradead.org>  <Pine.LNX.4.61.0501271539550.13927@chimarrao.boston.redhat.com>
  <20050127204217.GA2481@infradead.org> <1106859409.5624.140.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, Arjan van de Ven wrote:
> 
> and then there are architectures with an upward growing stack....
> and maybe the alignment will even vary per cpu type (runtime) for some
> architectures? Maybe arch maintainers can jump in quickly to say if a
> scheme with a per arch shift factor would be sufficient or if all kinds
> of horrors would creep up for them  (in which case a per arch function
> would be more suitable)

I think it's much nicer to just have the generic randomization hook, and 
not try to do something fancy. It's not like this is complex, and it's a 
lot better to have the same (simple) code duplicated five times than it is 
to make a (much more complex) interface to have things shared.

		Linus
