Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVDEUEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVDEUEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDEUEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:04:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261929AbVDEUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:02:44 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Josselin Mouette <joss@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20050405195044.GA25295@havoc.gtf.org>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>
	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com>
	 <1112723637.4878.14.camel@mirchusko.localnet> <4252E6C1.5010701@pobox.com>
	 <1112730024.6275.89.camel@laptopd505.fenrus.org>
	 <20050405195044.GA25295@havoc.gtf.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 22:02:32 +0200
Message-Id: <1112731353.6275.98.camel@laptopd505.fenrus.org>
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


> > actually there is; you just perfectly described it. Until we have
> > drivers that can use such firmware (and need it in initrds and the like)
> > infrastructure for that is unlikely to come into existence, and until
> > there is such infrastructure, driver authors like you are unlikely to
> > want to transition to loading firmware.  Now there is also your other
> > point about the request_firmware() interface being too primitive, and
> > that sure sounds valid. So to move forward two things need to happen
> > 
> > 1) the infrastructure needs expanding to be useful for more drivers
> > 
> > 2) the chicken and egg stalemate needs breaking. One way to do that is
> > to have dual-mode drivers for a while (eg drivers that request_firmware
> > () and if that fails, use the built-in firmware) so that the other
> > outside-the-kernel infrastructure can be developed and deployed.
> 
> The tg3 firmware should be delivered with the kernel; and any
> infrastructure that does not continue to work seamlessly with
> firmware-separate-from-tg3 is a non-starter.

I'm not arguing that

>   That's why I say there's
> no chicken-and-egg:  presumption of such implies half a solution.

I think you haven't read what I wrote. The part that makes up the
chicken-and-egg problem is the part where there is no infrastructure to
USE such firmware in initrds, to distribute it with the kernel image
etc. 

> Dual mode drivers are only useful for the 1-2 developers working on
> firmware loading.

and for the distro people who need to get their distro to do this sort
of thing very smoothly. It also, to put it bluntly, shuts the "fanatics"
up because they have their solution immediately, while others that may
need more time to get their distro ready, have such more time. I don't
have the illusion that any distro will do the infrastructure work if
there are no drivers that are going to use it. Nor do I have the
illusion that driver writers will make a hard switch until such
infrastructure is out there en masse.

Note that I don't even mention anything about not shipping the firmware
in the kernel tarbal. It might be an option in the end, depending on how
the infrastructure developers; but that is not part of the stalemate
that I see. You seem to be focused on only that thing, but to be honest,
for me that is the least interesting/controversial part.



