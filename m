Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVDEJet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDEJet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDEJch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:32:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38878 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261652AbVDEJ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:28:24 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050405091144.GA18219@lst.de>
References: <20050404141647.GA28649@pegasos>
	 <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos>
	 <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
	 <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	 <1112689164.3086.100.camel@icampbell-debian>
	 <20050405083217.GA22724@pegasos>
	 <1112690965.3086.107.camel@icampbell-debian>
	 <20050405091144.GA18219@lst.de>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:28:07 +0200
Message-Id: <1112693287.6275.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Tue, 2005-04-05 at 11:11 +0200, Christoph Hellwig wrote:
> On Tue, Apr 05, 2005 at 09:49:25AM +0100, Ian Campbell wrote:
> > I don't think you did get a rejection, a few people said that _they_
> > weren't going to do it, but if you want to then go ahead. I think people
> > are just fed up of people bringing up the issue and then failing to do
> > anything about it -- so prove them wrong ;-)
> 
> Actually patches to add firmware loader support to tg3 got rejected.

I think they will be accepted if they first introduce a transition
period where tg3 will do request_firmware() and only use the built-in
firmware if that fails. Second step is to make the built-in firmware a
config option and then later on when the infrastructure matures for
firmware loading/providing firmware it can be removed from the driver
entirely.

One of the sticking points will be how people get the firmware; I can
see the point of a kernel-distributable-firmware project related to the
kernel (say on kernel.org) which would provide a nice collection of
distributable firmwares (and is appropriately licensed). Without such
joint infrastructure things will always be a mess and in that context I
can see the point of the driver authors not immediately wanting to
switch exclusively. Simply because they'll get swamped with email about
how the driver doesn't work...

