Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbTLLOEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbTLLOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:04:45 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:6584 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265246AbTLLOEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:04:43 -0500
Date: Fri, 12 Dec 2003 15:04:35 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212140435.GF6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <200312111432.12683.rob@landley.net> <20031212125513.GC6112@wohnheim.fh-wedel.de> <1071235698.27730.146.camel@tribesman.namesys.com> <20031212134301.GD6112@wohnheim.fh-wedel.de> <1071237163.26354.154.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1071237163.26354.154.camel@tribesman.namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 16:52:43 +0300, Vladimir Saveliev wrote:
> On Fri, 2003-12-12 at 16:43, Jörn Engel wrote:
> > On Fri, 12 December 2003 16:28:18 +0300, Vladimir Saveliev wrote:
> > > 
> > > Sorry,
> > > but doesn't truncate do almost exactly what "make hole" is supposed to
> > > do?
> > 
> > Yeah, *almost* exactly.  Some people happen to care about the almost.
> > 
> 
> I meant: where are those tons of problems (except for the fact that
> "make hole" is obviously something without which one can live just
> fine)? 

Pretty much, yes.  As hinted at before, holes are just special cases
of a more general problem, block pointer handling.  On my hard drive,
there are literally millions of identical blocks.  If the filesystem
knew about those, it throw away most of them and just point to the
blocks from different files (or maybe just file positions).

A hole is simply a file offset pointing to a special and very common
shared block, but there are many others.

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
