Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVDEJkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVDEJkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDEJfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:35:47 -0400
Received: from verein.lst.de ([213.95.11.210]:20919 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261656AbVDEJdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:33:18 -0400
Date: Tue, 5 Apr 2005 11:32:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405093258.GA18523@lst.de>
References: <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112693287.6275.30.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:28:07AM +0200, Arjan van de Ven wrote:
> I think they will be accepted if they first introduce a transition
> period where tg3 will do request_firmware() and only use the built-in
> firmware if that fails.

Fine with me.

> Second step is to make the built-in firmware a
> config option and then later on when the infrastructure matures for
> firmware loading/providing firmware it can be removed from the driver
> entirely.

I think the infrasturcture is quite mature.  We have a lot of drivers
that require it to function.

> One of the sticking points will be how people get the firmware; I can
> see the point of a kernel-distributable-firmware project related to the
> kernel (say on kernel.org) which would provide a nice collection of
> distributable firmwares (and is appropriately licensed). Without such
> joint infrastructure things will always be a mess and in that context I
> can see the point of the driver authors not immediately wanting to
> switch exclusively. Simply because they'll get swamped with email about
> how the driver doesn't work...

I agree.  And that really doesn't need a lot of infrastructure,
basically just a tarball that unpacks to /lib/firmware, maybe a specfile
and debian/ dir in addition.
