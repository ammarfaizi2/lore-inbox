Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUBOTgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBOTgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:36:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:48543 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265175AbUBOTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:36:09 -0500
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040215185331.A8719@infradead.org>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
Content-Type: text/plain
Message-Id: <1076873760.21477.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 20:36:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 15.02.2004 schrieb Christoph Hellwig um 19:53:

> > > What's holding it back?  I'd rather get rid of all the cryptoloop crap
> > > sooner or later.
> > 
> > Well, nothing. It's in the dm-unstable tree for some time now. It
> > depends on when Joe plans to submit it. His last words were "in the next
> > couple of months". I don't know what that means exactly.
> 
> Is there a technical reason holding it back, e.g. a depency on core DM
> changes?  If not please submit it instead of waiting any longer.

The only reason, I guess, is that it depends on this very small
dm-daemon thing:
http://people.sistina.com/~thornber/dm/patches/2.6-unstable/2.6.2/2.6.2-udm1/00016.patch

Some other dm targets in the unstable tree use this too, it's just to
have very simple bottom-half processing in a separate thread with
synchronous start and stop functions.

Especially since dm-crypt was announced in a german linux magazine two
weeks ago people keep asking me when to expect it in the kernel. And to
delay it for some months just because there might be changes to
dm-daemon, which would be almost trivial, is a stupid reason to hold it
back if you ask me. :(


