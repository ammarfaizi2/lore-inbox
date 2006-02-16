Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWBPEwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWBPEwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 23:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBPEwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 23:52:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932464AbWBPEwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 23:52:53 -0500
Date: Wed, 15 Feb 2006 20:51:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: selhorst@crypto.rub.de, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr, kjhall@us.ibm.com
Subject: Re: [PATCH] Infineon TPM: IO-port leakage fix, WTX-bugfix
Message-Id: <20060215205140.46819b18.akpm@osdl.org>
In-Reply-To: <20060215203929.52ac2197.rdunlap@xenotime.net>
References: <43F33013.4020305@crypto.rub.de>
	<20060215203929.52ac2197.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Wed, 15 Feb 2006 14:43:47 +0100 Marcel Selhorst wrote:
> 
> > Dear all,
> > 
> > this patch fixes IO-port leakage from request_region in case of error during TPM
> > initialization, adds more pnp-verification and fixes a WTX-bug.
> > 
> > Best regards,
> > Marcel Selhorst
> > 
> > Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
> > ---
> > 
> > --- linux-2.6.16-rc2/drivers/char/tpm/tpm_infineon.c.old	2006-02-08
> > 11:45:09.000000000 +0100
> 
> Those 2 lines ^^^^^ should have been one line.  Email client strikes again.

Curiously patch(1) didn't care about that.

> > +
> > +err_release_region:
> > +release_region(tpm_inf.base, TPM_INF_PORT_LEN);
> > +release_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN);
> > +
> > +err_last:
> > +return rc;
> >  }
> 
> The release_region() calls and return should be indented one tab stop.

Yeah, I fixed that up.

> (email client again??)

I doubt it.
