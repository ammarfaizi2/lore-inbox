Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWD1RsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWD1RsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWD1RsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:48:15 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:51883 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751734AbWD1RsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:48:15 -0400
Date: Fri, 28 Apr 2006 19:47:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060428174754.GF30532@wohnheim.fh-wedel.de>
References: <20060428193708.5853da36.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060428193708.5853da36.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 April 2006 19:37:08 +0200, Michael Holzheu wrote:
>  
> +static void *diag204_get_buffer(enum diag204_format fmt, int *pages)
> +{
> +	void *buf;
> +
> +	if (fmt == INFO_SIMPLE)
> +		*pages = 1;
> +	else
> +		*pages = diag204(SUBC_RSI | fmt, 0, 0);
> +
> +	if (*pages <= 0)
> +		return ERR_PTR(-ENOSYS);

Is -ENOSYS the right thing here?  I thought it was for stuff not
implemented by Linux.  If the hardware or some hypervisor would return
-ENOSYS, it would be -EIO from Linux' perspective.  But I may be
wrong.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
