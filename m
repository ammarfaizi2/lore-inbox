Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUD3LJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUD3LJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUD3LJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:09:05 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:45729 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S265148AbUD3LIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:08:47 -0400
Message-ID: <1083323300.409233a4459e3@www.imp.polymtl.ca>
Date: Fri, 30 Apr 2004 13:08:20 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rik van Riel <riel@redhat.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
References: <Pine.SGI.4.53.0404291447220.732952@subway.americas.sgi.com> <Pine.LNX.4.44.0404291719400.9152-100000@chimarrao.boston.redhat.com> <20040430071750.A8515@infradead.org>
In-Reply-To: <20040430071750.A8515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.90.72.1
X-Poly-FromMTA: (c4.si.polymtl.ca [132.207.4.29]) at Fri, 30 Apr 2004 11:08:20 +0000
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.25.0.2; VDF 6.25.0.39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Christoph Hellwig <hch@infradead.org>:

> > I suspect there's a rather good chance of merging a common
> > PAGG/CKRM infrastructure, since they pretty much do the same
> > thing at the core and they both have different functionality
> > implemented on top of the core process grouping.
> 
> Still doesn't make a lot of sense.  CKRM is a huge cludgy beast poking
> everywhere while PAGG is a really small layer to allow kernel modules
> keeping per-process state.  If CKRM gets merged at all (and the current
> looks far to horrible and the gains are rather unclear) it should layer
> ontop of something like PAGG for the functionality covered by it.

And what about put the management of containers outside the kernel. We could for
exemple use a program that will listen file /proc/acct_event and execute a
programs to handle the event like ACPID does. Of course it will need some kernel
modifications but those modifications will be small as process aggregation will
be done outside the kernel. We could also use relayfs to exchange datas between
user program and the kernel.

Guillaume
