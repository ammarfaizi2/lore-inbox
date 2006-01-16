Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWAPOQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWAPOQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWAPOQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:16:39 -0500
Received: from mail.dvmed.net ([216.237.124.58]:28832 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750811AbWAPOQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:16:38 -0500
Message-ID: <43CBAABC.6070200@pobox.com>
Date: Mon, 16 Jan 2006 09:16:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>, jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
References: <20060115135728.7b13996d.rdunlap@xenotime.net>
In-Reply-To: <20060115135728.7b13996d.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Randy.Dunlap wrote: > From: Randy Dunlap
	<rdunlap@xenotime.net> > > Put SATA into its own menu. Reason: using
	SCSI is an > implementation detail that users need not know about. > >
	Enabling SATA selects SCSI since SATA uses SCSI as a function > library
	supplier. It also enables BLK_DEV_SD since that is > what SATA drives
	look like in Linux. > > Signed-off-by: Randy Dunlap
	<rdunlap@xenotime.net> > --- > drivers/Kconfig | 2 >
	drivers/scsi/Kconfig | 138 > drivers/scsi/Kconfig.sata | 142
	++++++++++++++++++++++++++++++++++++++++++++++ > 3 files changed, 144
	insertions(+), 138 deletions(-) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Put SATA into its own menu.  Reason:  using SCSI is an
> implementation detail that users need not know about.
> 
> Enabling SATA selects SCSI since SATA uses SCSI as a function
> library supplier.  It also enables BLK_DEV_SD since that is
> what SATA drives look like in Linux.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/Kconfig           |    2 
>  drivers/scsi/Kconfig      |  138 --------------------------------------------
>  drivers/scsi/Kconfig.sata |  142 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 138 deletions(-)

This needs to be done after the code gets moved to drivers/ata...

	Jeff



