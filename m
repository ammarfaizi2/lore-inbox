Return-Path: <linux-kernel-owner+w=401wt.eu-S1754062AbXABNzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbXABNzf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbXABNze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:55:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:42649 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062AbXABNze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:55:34 -0500
In-Reply-To: <200701021238.36297.m.kozlowski@tuxland.pl>
References: <200701021238.36297.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: vio of_node_put cleanup
Date: Tue, 2 Jan 2007 14:55:40 +0100
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void __devinit vio_dev_release(struct device *dev)
>  {
> -	if (dev->archdata.of_node) {
> -		/* XXX should free TCE table */
> -		of_node_put(dev->archdata.of_node);
> -	}
> +	/* XXX should free TCE table */
> +	of_node_put(dev->archdata.of_node);
>  	kfree(to_vio_dev(dev));
>  }

The comment used to be inside the "if" block, is this
change correct?

[And, do we want all these changes anyway?  I don't care
either way, both sides have their pros and their cons --
just asking :-) ]


Segher

