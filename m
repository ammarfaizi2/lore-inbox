Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVA0RwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVA0RwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVA0RuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:50:04 -0500
Received: from canuck.infradead.org ([205.233.218.70]:53255 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262684AbVA0Rrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:47:40 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <41F92721.1030903@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 18:47:30 +0100
Message-Id: <1106848051.5624.110.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 12:38 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> > 
> > The patch below replaces the existing 8Kb randomisation of the userspace
> > stack pointer (which is currently only done for Hyperthreaded P-IVs) with a 
> > more general randomisation over a 64Kb range.
> > 
> 
> 64k of stack randomization is trivial to evade. 

I think you're focussing on the 64k number WAY too much. Yes it's too
small. But it's an initial number to show the infrastructure and get it
tested. Yes it should and will be increased later on in the patch
series.

Same for the other heap randomisation.

This thing is about getting the infrastructure in place and used. The
actual numbers are mere finetuning that can be done near the end.


