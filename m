Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbTCaWku>; Mon, 31 Mar 2003 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbTCaWkt>; Mon, 31 Mar 2003 17:40:49 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9732 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261884AbTCaWks>; Mon, 31 Mar 2003 17:40:48 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303312251.h2VMp8gv000270@81-2-122-30.bradfords.org.uk>
Subject: Re: Delaying writes to disk when there's no need
To: piggin@cyberone.com.au (Nick Piggin)
Date: Mon, 31 Mar 2003 23:51:08 +0100 (BST)
Cc: cfriesen@nortelnetworks.com, helgehaf@aitel.hist.no, erik@hensema.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E88C29A.7050308@cyberone.com.au> from "Nick Piggin" at Apr 01, 2003 08:35:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the memory does get written to again before the writeout timeout
> then yeah its used some cpu, memory, pci, etc that it didn't have
> to.

It will presumably also have filled the cache with the writeout data.

> > Ultimately its all a tradeoff.  Do you write now, or do you hold off 
> > and hope that you can throw away some of the writes because new stuff 
> > will home in to overwrite them?
> 
> Yes it is a tradeoff. Having an idle disk gives more weight to "write now".

Not necessarily.  What if you are using a solid state disk which only
allows a relatively low number of re-write cycles?  What if the disk
is spun down, and spinning it up uses a lot of power?  On a laptop,
you don't necessarily want the disk spinning up just to write one
sector.

John.
