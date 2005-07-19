Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVGSSke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGSSke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGSSke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:40:34 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:14371 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261639AbVGSSkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:40:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=V0yPzKWy+QjpkMjDAjjFwgGXgov0gmsQqAgdSnXBQWQs1U8hTfpOyssEobGwku02hAFpYuPvGw5JbuIiWSjEZgmTIAADvA//DLiNKkF+HyalDZjjyFptAzo8C/EDmasMwURKjLTfuQW5KPGHpTOHH1RI3hueIBc5LwBfOPl4BCg=
Date: Tue, 19 Jul 2005 22:47:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk, gregkh@suse.de
Subject: Re: [PATCH] jsm driver - Linux-2.6.12.3
Message-ID: <20050719184721.GA11325@mipter.zuzino.mipt.ru>
References: <1121795600.3756.25.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121795600.3756.25.camel@siliver.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 12:53:20PM -0500, V. ANANDA KRISHNAN wrote:
> This patch takes care of (1) compiler warnings which displays the mixing
> of declarations and code

With what gcc version and what CFLAGS?

> (2) dynamic allocation of major device number
> instead of the static number 253 (3) the version update to reflect the
> changes in the patch.

> --- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_driver.c
> +++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_driver.c

> + * CHANGE LOG:
> + * Jul 18, 2005: Changed the major number changed to 0 to use the dynamic
> + *	allocation of major number by OS.
> + *

ChangeLog maintenance is the job of SCM. Don't add useless comments.

> --- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_neo.c
> +++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_neo.c

> -	u8 ier = readb(&ch->ch_neo_uart->ier);
> -	u8 efr = readb(&ch->ch_neo_uart->efr);
> +	u8 ier, efr;
> +	ier = readb(&ch->ch_neo_uart->ier);
> +	efr = readb(&ch->ch_neo_uart->efr);

