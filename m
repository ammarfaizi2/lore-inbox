Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWDFUD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWDFUD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWDFUD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:03:27 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:22731 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751306AbWDFUD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:03:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mx9S4qcFey8+tpk2/YTkoabC027s1bB/O+5TW1P3JAI3pMwmnmN6tNr2L+6+MK4GMl9npC4cpeR6OPkaUu9rR5BoxLt8uR82kGsjUIpKMPRjzsZej8e1A6v4fbh3vDd3qs9XjprpWN4bODBKS8mFekII7+di0/r4ajQXr8fP9Lo=
Date: Fri, 7 Apr 2006 00:03:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: philb@gnu.org, tim@cyberelk.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/parport/share.: unexport parport_get_port
Message-ID: <20060406195005.GA7167@mipter.zuzino.mipt.ru>
References: <20060405163727.GH8673@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405163727.GH8673@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 06:37:27PM +0200, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(parport_get_port).

> --- linux-2.6.17-rc1-mm1-full/drivers/parport/share.c.old
> +++ linux-2.6.17-rc1-mm1-full/drivers/parport/share.c

> -EXPORT_SYMBOL(parport_get_port);
>  EXPORT_SYMBOL(parport_put_port);

This looks wrong even it's unused. Think exporting kfree() and not
exporting kmalloc().

