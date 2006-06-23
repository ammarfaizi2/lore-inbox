Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWFWOSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFWOSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFWOSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:18:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750742AbWFWOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:18:08 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Arjan van de Ven <arjan@infradead.org>
To: Jason Baron <jbaron@redhat.com>
Cc: Robert Hancock <hancockr@shaw.ca>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:18:00 +0200
Message-Id: <1151072280.3204.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 10:05 -0400, Jason Baron wrote:
> On Fri, 23 Jun 2006, Arjan van de Ven wrote:
> 
> > 
> > > 
> > > hi,
> > > 
> > > So if i create a PROT_WRITE only mapping and then read from first and then 
> > > writte to it a get a SEGV. However, if i write to it first and then read 
> > > from it, i don't get a SEGV...Why should the read/write ordering matter? 
> > 
> > it matters only on those cpus that don't have explicit/separate read
> > permissions (just like PROT_EXEC is implied on cpus that don't have a
> > special permission bit for that)...
> > 
> > 
> > 
> 
> i understand that, but i'd like to see it changed so that i don't get a 
> SEGV when i read first on those cpus. ?

why? You asked for this you get it in all cases we can deliver what you
asked...

> The current behavior, besides being 
> inconsistent, is rather confusing...in addition, if ptes are copied 
> instead of faulted i get yet another type of behavior...

same for prefault I suppose, but still.

you ask for it, and the kernel is supposed to deliver the best behavior
it can.


