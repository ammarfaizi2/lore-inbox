Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTLWM2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 07:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTLWM2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 07:28:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:6159 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265115AbTLWM2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 07:28:30 -0500
Date: Tue, 23 Dec 2003 12:27:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 1/2] Add dm-daemon
Message-ID: <20031223122751.A6498@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Fruhwirth Clemens <clemens@endorphin.org>,
	Joe Thornber <thornber@sistina.com>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222214952.GA13103@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031222214952.GA13103@leto.cs.pocnet.net>; from christophe@saout.de on Mon, Dec 22, 2003 at 10:49:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 10:49:52PM +0100, Christophe Saout wrote:
> Hi.
> 
> The first patch adds dm-daemon.c/.h.
> 
> The code is from Joe Thornbers current unstable device-mapper patchset.

This should really be in generic code, not in DM.  I remember I did
something similar as kthread abstraction a while ago, but it didn't head
anywhere..

> diff -Nur linux-2.6.0.orig/drivers/md/dm.h linux-2.6.0/drivers/md/dm.h
> --- linux-2.6.0.orig/drivers/md/dm.h	2003-11-24 02:31:53.000000000 +0100
> +++ linux-2.6.0/drivers/md/dm.h	2003-12-22 17:56:05.000000000 +0100
> @@ -20,6 +20,12 @@
>  #define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
>  
>  /*
> + * FIXME: There must be a better place for this.
> + */
> +typedef typeof(jiffies) jiffy_t;

Eeek..

