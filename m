Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTFCTZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFCTZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:25:21 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:47633 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263632AbTFCTZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:25:21 -0400
Date: Tue, 3 Jun 2003 20:38:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc7
Message-ID: <20030603203844.A25771@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <5.1.0.14.2.20030603204118.00a04728@pop.t-online.de> <200306032049.18987.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200306032049.18987.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Tue, Jun 03, 2003 at 08:50:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:50:00PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 03 June 2003 20:45, Margit Schubert-While wrote:
> 
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21-rc7; fi
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc7/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> 
> attached.
> 
> hch: I know what you'll say, so don't reply ;-))

So add the message yourself if you don't want me to reply.

For those who haven't heard before:  this is _not_ a correct
fix.  proc_get_inode is not exported for a reason and the whole
procfs mess in comx needs a rewrite.  Given that no one looked
into this over the last three years I guess we should rather
remove the driver..

