Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSHQUBD>; Sat, 17 Aug 2002 16:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHQUBD>; Sat, 17 Aug 2002 16:01:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30194 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318717AbSHQUBC>; Sat, 17 Aug 2002 16:01:02 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020816170908.G31052@work.bitmover.com>
References: <20020816163642.D31052@work.bitmover.com>
	<Pine.LNX.4.44.0208161657240.1674-100000@home.transmeta.com> 
	<20020816170908.G31052@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 21:04:15 +0100
Message-Id: <1029614655.4647.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 01:09, Larry McVoy wrote:
> > I actually don't think it's the people as much as it is the ridiculous 
> > linkages inside ide.c and the hugely complicated rules. The code is messy.
> 
> So of all the people you know floating around in "active hacker" state, who
> seems like the sort of person who could handle this mess?  If there is no
> person, is there a description which is more specific than "wanted: person
> who wants thankless abusive non-payed job to clean up what is inherently a
> mess"?  

IMHO you need
	-	An understanding of ATA (which is the protocol
		equivalent of object oriented cobol)
	-	The ability to work with vendors (it needs to be someone
		at a company because many vendors won't NDA with 
		individuals even if they are happy with GPL code off 
		their data sheet)
	-	Someone who has taste in code and understands how to
		beat code into shape without breaking it
	-	The ability to deduce the other errata the vendor forgot
		to tell you about or doesn't want to admit exists for 
		fear of US lawsuits (I kid you not)
	-	A good understanding of the block layer and its locking
		especially because IDE has a heirarchy of contention 
		problems:
			two drives one bus
			two channels one DMA engine
			two controllers one I/O at a time
			ISA IRQ sharing locks


