Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVAKIbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVAKIbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVAKIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:31:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:48904 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262562AbVAKIbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:31:50 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjan@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1105367014.11462.13.camel@lade.trondhjem.org>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Jan 2005 09:31:39 +0100
Message-Id: <1105432299.3917.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
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

On Mon, 2005-01-10 at 09:23 -0500, Trond Myklebust wrote:
> må den 10.01.2005 Klokka 09:38 (+0100) skreiv Arjan van de Ven:
> >  
> > > is "sooner or later" and "maybe someone else uses it" worth making
> > > everyone elses kernel bigger by 500 bytes of code ?
> > 
> > eh 60 not 500; sorry need coffee
> 
> It's an API that provides *necessary* functionality for those
> filesystems that wish to override the standard flock(). It was very
> recently introduced by a third party, so we haven't had time to code up
> an NFS flock yet.

where "recently" is last september....
bloating the kernel unused since then...

> Removing it now will just mean that we have to reintroduce it in a month
> or so when NFS and the other filesystems start to catch up.

if NFS indeed is going to use this in a month then you're probably
right, bloating all kernels for another few weeks (before 2.6.11 is out
anyway) isn't a big deal. I'm looking forward to nfs using this in this
timeframe...

If it is going to take a LOT longer though I still feel it's wrong to
bloat *everyones* kernel with this stuff.

(you may think "it's only 100 bytes", well, there are 700+ other such
functions, total that makes over at least 70Kb of unswappable, wasted
memory if not more.)

