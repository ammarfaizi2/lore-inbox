Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263553AbUJ2WwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbUJ2WwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbUJ2Wrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:47:51 -0400
Received: from colo.lackof.org ([198.49.126.79]:17371 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263539AbUJ2WpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:45:14 -0400
Date: Fri, 29 Oct 2004 16:45:12 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, grundler@parisc-linux.org, gnb@sgi.com
Subject: Re: [PATCH] deviceiobook.tmpl update
Message-ID: <20041029224512.GB11024@colo.lackof.org>
References: <200410291541.49481.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291541.49481.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:41:49PM -0700, Jesse Barnes wrote:
> Greg and Grant, how does this small update look?

looks good to me.

thanks,
grant

> 
> Thanks,
> Jesse

> ===== Documentation/DocBook/deviceiobook.tmpl 1.5 vs edited =====
> --- 1.5/Documentation/DocBook/deviceiobook.tmpl	2004-10-25 13:06:49 -07:00
> +++ edited/Documentation/DocBook/deviceiobook.tmpl	2004-10-29 15:38:01 -07:00
> @@ -195,7 +195,12 @@
>  	be strongly ordered coming from different CPUs.  Thus it's important
>  	to properly protect parts of your driver that do memory-mapped writes
>  	with locks and use the <function>mmiowb</function> to make sure they
> -	arrive in the order intended.
> +	arrive in the order intended.  Issuing a regular <function>readX
> +	</function> will also ensure write ordering, but should only be used
> +	when the driver has to be sure that the write has actually arrived
> +	at the device (not that it's simply ordered with respect to other
> +	writes), since a full <function>readX</function> is a relatively
> +	expensive operation.
>        </para>
...
