Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbTLLOCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbTLLOCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:02:08 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11913 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265242AbTLLOCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:02:02 -0500
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
From: Vladimir Saveliev <vs@namesys.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312120753.11906.rob@landley.net>
References: <20031211125806.B2422@hexapodia.org>
	 <20031212125513.GC6112@wohnheim.fh-wedel.de>
	 <1071235698.27730.146.camel@tribesman.namesys.com>
	 <200312120753.11906.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1071237719.27730.158.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Dec 2003 17:01:59 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 16:53, Rob Landley wrote:
> On Friday 12 December 2003 07:28, Vladimir Saveliev wrote:
> > Hi
> >
> > On Fri, 2003-12-12 at 15:55, Jörn Engel wrote:
> > > On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> > > > On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> > > > > If you really do it, please don't add a syscall for it.  Simply check
> > > > > each written page if it is completely filled with zero.  (This will
> > > > > be a very quick check for most pages, as they will contain something
> > > > > nonzero in the first couple of words)
> > > >
> > > > Cache poisoning, streaming writes to large RAID arrays...  There are
> > > > about 8 zllion reasons not to do this.  Really.  (It defeats the whole
> > > > purpose of DMA, doesn't it?)
> >
> > Sorry,
> > but doesn't truncate do almost exactly what "make hole" is supposed to
> > do?
> 
> I have a 2 gigabyte file.  I want to punch a hole from 257 megabytes to 364 
> megabytes, saving over 100 megs of disk space.  I do NOT want to have to copy 
> off and rewrite 1.6 gigabytes of data from the end of the file.  (There may 
> not even be enough room on the disk, and it would take a long time anyway.)
> 
ok.
But I asked why would "make hole" have problems you list (8 zillions)
and truncate would not have them?

> No, it doesn't do the same thing.  Truncate is always to end of file.  Punch 
> hole is like a write, it takes a length.  lseek(pos), punch(length).
> 
> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

