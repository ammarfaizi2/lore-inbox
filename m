Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWBWPO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWBWPO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWBWPO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:14:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35307 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751372AbWBWPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:14:58 -0500
Subject: Re: 2.6.16-rc4-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m2fymai5yp.fsf@vador.mandriva.com>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	 <43FC6B8F.4060601@ums.usu.ru> <43FC8290.8070408@ums.usu.ru>
	 <1140696659.19361.13.camel@localhost.localdomain>
	 <m2fymai5yp.fsf@vador.mandriva.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 15:19:05 +0000
Message-Id: <1140707945.4332.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-23 at 14:02 +0100, Thierry Vignaud wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > The libata and pata_via in -mm are a bit out of date. The current
> > libata patch and driver for 2.6.16-rc4 knows how to do per device
> > modes.
> 
> does this include the other pata_* drivers?

All the PATA in -mm is a bit out of date right now. I'm getting so much
more third party testing by releasing patches versus base not -mm that
it seems best to ge the patches knocked into a decent shape and then
feed them through Jeff into -mm and base.

The patch deals with
	- 40pin cables (generically)
	- DMA mode filtering by card rules
	- Per device timing

and some drivers use the command issue wrapping in the core code to
switch mode programming to support multiple DMA timings on hardware that
doesn't do it at hardware level.

Alan

