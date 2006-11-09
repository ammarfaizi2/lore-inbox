Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754814AbWKITTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbWKITTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbWKITTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:19:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:17080 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754814AbWKITTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:19:44 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: Badari Pulavarty <pbadari@us.ibm.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1163087946.3879.43.camel@frecb000686>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Thu, 09 Nov 2006 11:18:06 -0800
Message-Id: <1163099886.29807.20.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 16:59 +0100, Sébastien Dugué wrote:

> @@ -1549,8 +1657,7 @@ int fastcall io_submit_one(struct kioctx
>  	ssize_t ret;
>  
>  	/* enforce forwards compatibility on users */
> -	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
> -		     iocb->aio_reserved3)) {
> +	if (unlikely(iocb->aio_reserved1)) {
>  		pr_debug("EINVAL: io_submit: reserve field set\n");
>  		return -EINVAL;

Is there a reason for not checking "aio_reserved3" ?
You are still not using it. Right ?

Thanks,
Badari

