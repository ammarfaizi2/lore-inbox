Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUBPC6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUBPC6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:58:41 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:53413 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265325AbUBPC6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:58:40 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, thornber@redhat.com, mikenc@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040215175337.5d7a06c9.akpm@osdl.org>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>
	 <20040215175337.5d7a06c9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076900296.5601.41.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 03:58:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Andrew Morton um 02:53:

> > +	  This device-mapper target allows you to create a device that
> >  +	  transparently encrypts the data on it. You'll need to activate
> >  +	  the required ciphers in the cryptoapi configuration in order to
> >  +	  be able to use it.
> 
> Is there more documentation that this?  I'd imagine a lot of crypto-loop
> users wouldn't have a clue how to get started on dm-crypt, especially if
> they have not used device mapper before.

Yes, there is. I'm going to collect it and put something together.

> And how do they migrate existing encrypted filesytems?

The current on-disk-layout is compatible with cryptoloop. The IV
generation mechanism is flexible though and will be extended to allow
for a more secure IV generation (like using a hash algorithm).

At the moment it supports no IC (ECB mode) or plain IV (sector number
truncated to 32 bit as IV).


