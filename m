Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUFCVbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUFCVbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUFCVbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:31:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:54714 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264337AbUFCVbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:31:16 -0400
Date: Thu, 3 Jun 2004 23:31:15 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: idebus setup problem (2.6.7-rc1)
Message-ID: <20040603213115.GA1107@MAIL.13thfloor.at>
Mail-Followup-To: "Zhu, Yi" <yi.zhu@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Auzanneau Gregory <mls@reolight.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:05:08PM +0800, Zhu, Yi wrote:
> Rusty Russell wrote:
> > 
> > Dislike this idea.  If you have hundreds of parameters, maybe it's
> > supposed to be a PITA? 
> 
> What's your idea to make module_param support alterable param
> names like ide3=xxx ?

hmm, what about making all those something like:

	ide=3:foo,bar;4:wossname

where ':' and ';' are arbitrarily chosen atm ...
or, if it should be handled at the 'argument' level
maybe the 'notion' of arrays would help, something
like
	
	ide[3]=foo,bar

where ide is defined as array of strings, size 16

best,
Herbert

> Thanks,
> -yi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
