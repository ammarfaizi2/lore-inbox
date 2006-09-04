Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWIENSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWIENSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIENSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:18:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14245 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964845AbWIENSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:18:51 -0400
Subject: Re: [PATCH] ide: Fix crash on repeated reset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060904193807.GA6118@rhlx01.fht-esslingen.de>
References: <1157378041.30801.78.camel@localhost.localdomain>
	 <20060904193807.GA6118@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 23:04:37 +0100
Message-Id: <1157407477.9018.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 21:38 +0200, ysgrifennodd Andreas Mohr:
> Hi,
> 
> On Mon, Sep 04, 2006 at 02:54:01PM +0100, Alan Cox wrote:
> >  	unsigned int sleeping	: 1;
> >  		/* BOOL: polling active & poll_timeout field valid */
> >  	unsigned int polling	: 1;
> > +	 	/* BOOL: in a polling reset situation. Must not trigger another reset yet */
> > +	unsigned	resetting  : 1;
> > +
> 
> Inconsistent variable type declarations/formatting?

Harmless but true. Updated in my tree.

Alan

