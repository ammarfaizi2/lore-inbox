Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVCVIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVCVIFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCVIFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:05:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262531AbVCVIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:05:40 -0500
Subject: Re: mmap/munmap bug
From: Arjan van de Ven <arjan@infradead.org>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hayim Shaul <hayim@post.tau.ac.il>, linux-kernel@vger.kernel.org
In-Reply-To: <20050322075658.GA32445@minantech.com>
References: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il>
	 <1111430042.6952.70.camel@laptopd505.fenrus.org>
	 <20050322075658.GA32445@minantech.com>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 09:05:33 +0100
Message-Id: <1111478733.7096.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 09:56 +0200, Gleb Natapov wrote:
> On Mon, Mar 21, 2005 at 07:34:02PM +0100, Arjan van de Ven wrote:
> > On Mon, 2005-03-21 at 17:32 +0200, Hayim Shaul wrote:
> > > Hi all,
> > > 
> > > I have an unexplained bug with mmap/munmap on 2.6.X.
> > > 
> > > I'm writing a kernel module that gives super-fast access to the network.
> > > It does so by doing mmap thus avoiding the memcpy to/from user.
> > 
> > well... you are aware the network stack already supports generic zero
> > copy networking, right ?
> > 
> Does it support zero copy not only for send but also for receive? Can we
> receive packets directly to userspace buffers?

that it can't currently, but without some major protocol stack rework
that's not going to be easy. If you want to help do that work,
excellent! Be sure to contact the people on net-dev mailinglist since
they are the ones having looked at this previously.



