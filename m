Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVDDXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDDXOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDDXMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:12:22 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:37264 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261477AbVDDXFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:05:32 -0400
Date: Mon, 4 Apr 2005 19:04:11 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: maximilian attems <janitor@sternwelten.at>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch 1/3] pnpbios eliminate bad section references
Message-ID: <20050404230411.GD27522@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	maximilian attems <janitor@sternwelten.at>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20050404181048.GA12394@sputnik.stro.at> <42519BF0.8090404@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42519BF0.8090404@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 12:56:32PM -0700, Randy.Dunlap wrote:
> maximilian attems wrote:
> >one of the last buildcheck errors on i386,
> >thanks Randy again for double checking.
> >
> >Fix pnpbios section references:
> >make dmi_system_id pnpbios_dmi_table __initdata
> >
> >Error: ./drivers/pnp/pnpbios/core.o .data refers to 00000100 R_386_32
> >.init.text
> >Error: ./drivers/pnp/pnpbios/core.o .data refers to 0000012c R_386_32
> >.init.text
> >
> >Signed-off-by: maximilian attems <janitor@sternwelten.at>
> >
> >
> >--- linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c.orig	2005-04-04 
> >19:11:37.814477672 +0200
> >+++ linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c	2005-04-04 
> >19:25:50.074402365 +0200
> >@@ -512,7 +512,7 @@
> > 	return 0;
> > }
> > 
> >-static struct dmi_system_id pnpbios_dmi_table[] = {
> >+static struct dmi_system_id pnpbios_dmi_table[] __initdata = {
> > 	{	/* PnPBIOS GPF on boot */
> > 		.callback = exploding_pnp_bios,
> > 		.ident = "Higraded P14H",
> 
> Looks OK to me, but I'd prefer to leave it up to Adam.....

Thank you for forwarding this to me.  It looks good.

Cheers,
Adam
