Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHRJZY>; Sun, 18 Aug 2002 05:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHRJZY>; Sun, 18 Aug 2002 05:25:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12818
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313305AbSHRJZX>; Sun, 18 Aug 2002 05:25:23 -0400
Date: Sun, 18 Aug 2002 02:19:40 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ed Sweetman <safemode@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
In-Reply-To: <1029654916.2037.0.camel@psuedomode>
Message-ID: <Pine.LNX.4.10.10208180215370.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.19-preempt

All bets are off because who knows what preempt is doing to the state
machines and in PIO you are dead.

You can not delay transaction of data between interrupts w/o having the
transport help out.  But the preempt don't get it.

If you push your request size down to 8k or to a page you preempt problems
will go away, only because granularity of requests.  And the price is
performance goes in the tank.  But this is preempt so who cares.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

