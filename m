Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWCFHql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWCFHql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWCFHql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:46:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40131 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751386AbWCFHql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:46:41 -0500
Date: Mon, 6 Mar 2006 08:46:39 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390 - fix match in ccw modalias
Message-ID: <20060306084639.05bd7a9b@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060306020024.GA25620@wavehammer.waldi.eu.org>
References: <20060306020024.GA25620@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 03:00:24 +0100
Bastian Blank <bastian@waldi.eu.org> wrote:

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index be97caf..c164b23 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -246,7 +246,7 @@ static int do_ccw_entry(const char *file
>  	    id->cu_model);
>  	ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
>  	    id->dev_type);
> -	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
> +	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_MODEL,
>  	    id->dev_model);
>  	return 1;
>  }

Patch makes sense to me.

> Martin: can you please push them through for 2.6.16? It breaks automatic
> loading of any dasd module.

I don't know whether Martin is operational this week, but I'd second an
inclusion into 2.6.16.

Cornelia
