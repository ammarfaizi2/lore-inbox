Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVDETz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVDETz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVDETxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:53:11 -0400
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:481 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261936AbVDETvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:51:10 -0400
Date: Tue, 5 Apr 2005 15:50:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Josselin Mouette <joss@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405195044.GA25295@havoc.gtf.org>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br> <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252E6C1.5010701@pobox.com> <1112730024.6275.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112730024.6275.89.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:40:24PM +0200, Arjan van de Ven wrote:
> 
> > * The firmware distribution infrastructure is basically non-existent. 
> > There is no standard way to make sure that a firmware separated from the 
> > driver gets to all users.
> > 
> > * The firmware bundling infrastructure is basically non-existent. 
> > (Arjan talked about this)  There needs to be a a way to ensure that the 
> > needed firmwares are automatically added to initramfs/initrd.
> > 
> > * There is no chicken-and-egg problem as Arjan mentions. 
> 
> actually there is; you just perfectly described it. Until we have
> drivers that can use such firmware (and need it in initrds and the like)
> infrastructure for that is unlikely to come into existence, and until
> there is such infrastructure, driver authors like you are unlikely to
> want to transition to loading firmware.  Now there is also your other
> point about the request_firmware() interface being too primitive, and
> that sure sounds valid. So to move forward two things need to happen
> 
> 1) the infrastructure needs expanding to be useful for more drivers
> 
> 2) the chicken and egg stalemate needs breaking. One way to do that is
> to have dual-mode drivers for a while (eg drivers that request_firmware
> () and if that fails, use the built-in firmware) so that the other
> outside-the-kernel infrastructure can be developed and deployed.

The tg3 firmware should be delivered with the kernel; and any
infrastructure that does not continue to work seamlessly with
firmware-separate-from-tg3 is a non-starter.  That's why I say there's
no chicken-and-egg:  presumption of such implies half a solution.

Dual mode drivers are only useful for the 1-2 developers working on
firmware loading.

Someone needs to make the effort to create and test a solution, rather
than half measures which -do- imply a c-and-e problem.

	Jeff



