Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWHATfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWHATfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWHATfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:35:36 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60036 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751847AbWHATff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:35:35 -0400
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0608011209560.18537@schroedinger.engr.sgi.com>
References: <20060801030443.GA2221@gondor.apana.org.au>
	 <20060731210418.084f9f5d.akpm@osdl.org>
	 <20060801050259.GA3126@gondor.apana.org.au>
	 <20060731225454.19981a5f.akpm@osdl.org>
	 <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
	 <1154459316.29772.5.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0608011209560.18537@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 15:35:13 -0400
Message-Id: <1154460913.30391.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 12:10 -0700, Christoph Lameter wrote:
> On Tue, 1 Aug 2006, Steven Rostedt wrote:
> 
> > If you set the alignment for ext3 the same as the size (ie 1024, 2048,
> > 4096 for the above respectively) then wouldn't that guarantee not
> > straddling a page?
> 
> Yes. But then that number must always be a fraction of pagesize.
> 

understood, as is 1024, 2048, and 4096 are.  Well, if pagesize is 4096
is 4096 really a fraction of 4096? :)

Also, isn't all sizes for kmalloc that are under pagesize a fraction of
the page size? Or more correctly, a power of 2?

-- Steve


