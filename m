Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbUKEIcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUKEIcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKEIcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:32:16 -0500
Received: from sd291.sivit.org ([194.146.225.122]:44189 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262571AbUKEIcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:32:02 -0500
Date: Fri, 5 Nov 2004 09:32:29 +0100
From: Stelian Pop <stelian@popies.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RESEND] pcmcia network drivers cleanup
Message-ID: <20041105083229.GC3996@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418AE490.1010304@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 09:25:20PM -0500, Jeff Garzik wrote:

> Stelian Pop wrote:
> >Hi,
> >
> >The attached patch:
> >  * cleans up the parameter passing (module_param() instead of 
> >  MODULE_PARM()
> >  * makes debugging work (PCMCIA_DEBUG does not exist anymore, make the
> >    Makefile test for CONFIG_PCMCIA_DEBUG and activate DEBUG in CFLAGS)
> >    and use the same debugging macros for every driver through code
> >    reuse.
> 
> Comments:
> 
> 1) Can you please separate module_param() and PCMCIA_DEBUG patches?

I will and resubmit later. The two changes were a bit related
(modifying the debugging made me do the module_param() cleanup 
because MODULE_PARM() and module_param() aren't both allowed
in the same module) that's why I originaly submitted a single patch.

> 2) why not use pr_debug()?

Because pr_debug doesn't take into account the verbosity level
like pn_dbg() does.  A lot of drivers in drivers/pcmcia/ do use
such a construction...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
