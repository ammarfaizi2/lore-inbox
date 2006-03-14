Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWCNI3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWCNI3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbWCNI3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:29:06 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:13197 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750963AbWCNI3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:29:04 -0500
Date: Tue, 14 Mar 2006 09:29:02 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg Smith <gsmith@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 16/17] s390: multiple subchannel sets support.
Message-ID: <20060314092902.7289d63e@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1142288308.3510.3.camel@localhost.localdomain>
References: <1140865922.3513.87.camel@localhost.localdomain>
	<20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
	<1142288308.3510.3.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 17:18:28 -0500
Greg Smith <gsmith@nc.rr.com> wrote:

> It seems this patch got dropped (it was in addition to the `s390:
> improve response code handling in chsc_enable_facility()' patch).

Whoops. This should get merged as well to avoid unneccessary checks.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

> diff -u -r a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> --- a/drivers/s390/cio/css.c	2006-03-13 12:54:16.000000000 -0500
> +++ b/drivers/s390/cio/css.c	2006-03-13 12:55:03.000000000 -0500
> @@ -409,6 +409,9 @@
>  		/* -ENXIO: no more subchannels. */
>  		case -ENXIO:
>  			return ret;
> +		/* -EIO: this subchannel set not supported. */
> +		case -EIO:
> +			return ret;
>  		default:
>  			return 0;
>  		}
> 
> 
