Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTEROQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTEROQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:16:12 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:4614 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262099AbTEROQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:16:12 -0400
Subject: Re: [patch] support 64 bit pci_alloc_consistent
From: James Bottomley <James.Bottomley@steeleye.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jes Sorensen <jes@wildopensource.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
In-Reply-To: <20030518142130.A30977@devserv.devel.redhat.com>
References: <16071.1892.811622.257847@trained-monkey.org>
	<1053250142.1300.8.camel@laptop.fenrus.com>
	<1053267471.10811.28.camel@mulgrave> 
	<20030518142130.A30977@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2003 09:28:45 -0500
Message-Id: <1053268130.10811.31.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 09:21, Arjan van de Ven wrote:
> On Sun, May 18, 2003 at 09:17:48AM -0500, James Bottomley wrote:
> > (it uses 32 bit addr and 32 bit len descriptors, but reduces len to 24
> > bits to steal the extra byte for 7 bits extra addressing).  However, it
> > is forced to request the full 64 bit address mask---I've never worked
> > out what will happen to it on a machine with more than 512GB memory.
> 
> Uh??? right now even in 2.4 arbitrary bitmasks are supported for
> non-coherent memory.

Ah, my mistake.  I keep forgetting there are two of these drivers in the
aic7xxx directory.  The 79xx does have a 64 bit descriptor and sets the
full width.  The 7xxx doesn't and sets a partial width.

Sorry,

James


