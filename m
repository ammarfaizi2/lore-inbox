Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTLLN2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTLLN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:28:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47752 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264568AbTLLN2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:28:19 -0500
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
From: Vladimir Saveliev <vs@namesys.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031212125513.GC6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org>
	 <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
	 <20031211194815.GA10029@wohnheim.fh-wedel.de>
	 <200312111432.12683.rob@landley.net>
	 <20031212125513.GC6112@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1071235698.27730.146.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Dec 2003 16:28:18 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 2003-12-12 at 15:55, Jörn Engel wrote:
> On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> > On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> > >
> > > If you really do it, please don't add a syscall for it.  Simply check
> > > each written page if it is completely filled with zero.  (This will be
> > > a very quick check for most pages, as they will contain something
> > > nonzero in the first couple of words)
> > 
> > Cache poisoning, streaming writes to large RAID arrays...  There are about 8 
> > zllion reasons not to do this.  Really.  (It defeats the whole purpose of 
> > DMA, doesn't it?)
> 

Sorry,
but doesn't truncate do almost exactly what "make hole" is supposed to
do?

> Yes, the obvious and stupid implementation has a ton of problems.
> Most likely the right approach is some sort of background deamon
> (garbage collector, defragmenter, journald, whatever you may call it)
> that does exacly this even after the fact for the last unchecked
> writes.  Asyncronous under load, possibly even synchronous when almost
> idle.
> 
> A stupid implementation would still help for some workload (few, while
> hurting many) and already get the code tested, so even a stupid
> implementation helps.
> 
> Jörn

