Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAOARV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAOARV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:17:21 -0500
Received: from palrel13.hp.com ([156.153.255.238]:61401 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264941AbUAOARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:17:16 -0500
Date: Wed, 14 Jan 2004 16:17:12 -0800
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-ID: <20040115001712.GA24056@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040112234332.GA1785@bougret.hpl.hp.com> <20040113142204.0b41403b.shemminger@osdl.org> <20040113162112.509edb71.davem@redhat.com> <20040114161324.61b7198f.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114161324.61b7198f.shemminger@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 04:13:24PM -0800, Stephen Hemminger wrote:
> Bug: dev_alloc_name returns the number of the slot used, so comparison needs
> to be < 0.
> 
> diff -Nru a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c	Wed Jan 14 16:09:02 2004
> +++ b/net/core/dev.c	Wed Jan 14 16:09:02 2004
> @@ -718,7 +718,7 @@
>  
>  	if (strchr(newname, '%')) {
>  		int err = dev_alloc_name(dev, newname);
> -		if (err)
> +		if (err < 0)
>  			return err;
>  		strcpy(newname, dev->name);
>  	}

	Doh ! I feel stupid.

	Jean
