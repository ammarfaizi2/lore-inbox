Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264158AbRFLDTj>; Mon, 11 Jun 2001 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264161AbRFLDTa>; Mon, 11 Jun 2001 23:19:30 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:2703 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S264158AbRFLDTO>; Mon, 11 Jun 2001 23:19:14 -0400
Date: Mon, 11 Jun 2001 22:17:59 -0500
From: "Glenn C. Hofmann" <hofmanng@swbell.net>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B243A33.8B32FCD6@mandrakesoft.com>
To: ghofmann@pair.com, Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Reply-to: ghofmann@pair.com
Message-id: <3B254397.16198.EB2CF@localhost>
MIME-version: 1.0
X-Mailer: Pegasus Mail for Win32 (v3.12c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, thank you, that makes it load and it also works with ifconfig and dhcp as a module.

Glenn C. Hofmann

On 10 Jun 2001, at 23:25 Jeff Garzik wrote:

> "Glenn C. Hofmann" wrote:
> > 
> > I have, as was suggested, built as a module, and get unresolved symbol do_softirq, so
> > this appears to be another problem in this driver with 2.4.6-pre2.  If I can help in any
> > way, please let me know, although I am by no means a programmer, just a tester.
> 
> edit kernel/ksyms.c:
> 
> -EXPORT_SYMBOL(do_softirq);
> +EXPORT_SYMBOL_NOVERS(do_softirq);
> 
> and see if that helps.
> 
> Errors about do_softirq are unrelated to a specific driver.
> 
> -- 
> Jeff Garzik      | Andre the Giant has a posse.
> Building 1024    |
> MandrakeSoft     |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


