Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVK3MiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVK3MiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVK3MiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:38:24 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:13196 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751164AbVK3MiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:38:24 -0500
Date: Wed, 30 Nov 2005 13:38:29 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Carlos Silva <r3pek@gentoo.org>
Cc: linux-dvb-maintainer@linuxtv.org, michael@mihu.de,
       linux-kernel@vger.kernel.org, adq_dvb@lidskialf.net
Message-ID: <20051130123829.GA26710@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Carlos Silva <r3pek@gentoo.org>, linux-dvb-maintainer@linuxtv.org,
	michael@mihu.de, linux-kernel@vger.kernel.org,
	adq_dvb@lidskialf.net
References: <1133261646.13000.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133261646.13000.19.camel@localhost>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.225.41
Subject: Re: [linux-dvb-maintainer] [PATCH] Fix budget-ci linking problem
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

On Tue, Nov 29, 2005, Carlos Silva wrote:
> Hi, a user reported that had linking problems when compiling the kernel.
> After looking at his problem I found out that there was missing the
> compilation of stv0297.c when budget-ci.c was selected. So I made this
> simple patch that solved the user's problem.
> The downstream bug report is this one:
> http://bugs.gentoo.org/show_bug.cgi?id=112997
> 
> If you need anything more from me, just mail me.
> 
> Signed-of-by: Carlos Silva <r3pek@gentoo.org>

I added your patch to linuxtv.org CVS when you first sent it.
Seems like I missed to send a confirmation mail, sorry about that. :-(

It should go into the kernel with the next set of dvb/v4l patches.

Thanks,
Johannes

> --- drivers/media/dvb/ttpci/Kconfig.old	2005-11-19 20:23:50.000000000 +0000
> +++ drivers/media/dvb/ttpci/Kconfig	2005-11-19 20:22:49.000000000 +0000
> @@ -81,6 +81,7 @@
>  	tristate "Budget cards with onboard CI connector"
>  	depends on DVB_CORE && PCI
>  	select VIDEO_SAA7146
> +	select DVB_STV0297
>  	select DVB_STV0299
>  	select DVB_TDA1004X
>  	help
