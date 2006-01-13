Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423081AbWAMW7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423081AbWAMW7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423075AbWAMW7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:59:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423081AbWAMW7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:59:23 -0500
Date: Fri, 13 Jan 2006 14:58:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       iinuxppc-embedded@gate.crashing.org, dave@cray.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-Id: <20060113145804.7f6ee236.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@gate.crashing.org> wrote:
>
> +static struct platform_driver mpc83xx_wdt_driver = {
> +	.probe		= mpc83xx_wdt_probe,
> +	.remove		= __devexit_p(mpc83xx_wdt_remove),
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= "mpc83xx_wdt",
> +	},
> +};

platform_driver.owner no longer needs to be initialised for some reason. 
I'll take that line out.
