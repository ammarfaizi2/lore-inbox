Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUBQCPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbUBQCPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:15:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:58003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265765AbUBQCPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:15:47 -0500
Date: Mon, 16 Feb 2004 18:15:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity
Message-ID: <20040216181546.A22989@build.pdx.osdl.net>
References: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Feb 16, 2004 at 08:34:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> Here's the patch, versioned against 2.6.3-rc3-mm1. Comments?

Aside of the dubious security value...the typical no #ifdefs apply here.

> +#ifdef CONFIG_SECURITY_RANDID
> +	if (security_enable_randid)
> +		id = ip_randomid();
> +	else
> +#endif

e.g. move the ifdef to header and move the if(enable) bit to ip_randomid().
ditto for all similar cases below.  it's not clear to me these are
particularly useful features though.

> + * 3. All advertising materials mentioning features or use of this software
> + *    must display the following acknowledgement:
> + *    This product includes software developed by Niels Provos.

Advertsing clause...this is not GPL compatible.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
