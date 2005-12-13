Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVLMJTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVLMJTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVLMJTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:19:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932591AbVLMJTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:19:39 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20051213090349.GE10088@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <1134460804.2866.17.camel@laptopd505.fenrus.org>
	 <20051213090349.GE10088@elte.hu>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 10:19:30 +0100
Message-Id: <1134465570.7362.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 10:03 +0100, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > even better than that, why not use the solution that we've implemented 
> > > for the -rt patchset, more than a year ago?
> > > 
> > > the solution i took was this:
> > > 
> > > - i did not touch the 'struct semaphore' namespace, but introduced a
> > >   'struct compat_semaphore'.
> > 
> > which I think is wrong. THis naming sucks. Sure doing a full sed on 
> > the tree is not pretty but it's also not THAT painful. And the pain of 
> > wrong names is something the kernel needs to carry around for years.
> 
> well, i'm all for renaming struct semaphore to struct mutex, but dont 
> the same arguments apply as to 'struct timer_list'?

don't think so; this is not a "lets do them one by one over the year",
this is a "do them all right now at once" move.

