Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVDEMPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVDEMPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDEMPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:15:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55521 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261707AbVDEMPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:15:12 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@lst.de>, Ian Campbell <ijc@hellion.org.uk>,
       Sven Luther <sven.luther@wanadoo.fr>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42527FF6.1080502@pobox.com>
References: <20050404182753.GC31055@pegasos>
	 <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
	 <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	 <1112689164.3086.100.camel@icampbell-debian>
	 <20050405083217.GA22724@pegasos>
	 <1112690965.3086.107.camel@icampbell-debian>
	 <20050405091144.GA18219@lst.de>
	 <1112693287.6275.30.camel@laptopd505.fenrus.org>
	 <20050405093258.GA18523@lst.de>  <42527FF6.1080502@pobox.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 14:14:56 +0200
Message-Id: <1112703297.6275.55.camel@laptopd505.fenrus.org>
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


> > I agree.  And that really doesn't need a lot of infrastructure,
> > basically just a tarball that unpacks to /lib/firmware, maybe a specfile
> > and debian/ dir in addition.
> 
> 
> At the moment there is -zero- infrastructure that would allow my tg3 to 
> continue working, when I upgrade to a tg3 driver with external firmware.
> 
> The user has to put a file in some location manually.
> 
> That's a complete non-starter, from a usability standpoint.

but unless we allow the driver to use such things, such infrastructure
won't come into existence either. It's a chicken-and-egg situation...
except that we can for a while make tg3 and others be both the chicken
and egg until the real chicken is there.

> Further, several firmwares, including tg3, are really a collection of 
> bits of information:  .text, .bss, and random variables (start addr, 
> image size, ...).  The current interface is complete crap for this sort 
> of setup.
> 
> The firmware loader really needs to be loading -archives- not individual 
> files.
> 
> We are a -long- way from moving the firmware out of the tg3 source code.

Yet that is no excuse to not at least start addressing the issues. What
you just listed are deficiencies in the kernel infrastructure, not doing
something because we have slightly suboptimal infrastructure isn't the
right thing.


