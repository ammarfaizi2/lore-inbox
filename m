Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWD0LtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWD0LtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWD0LtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:49:03 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:11744 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965024AbWD0LtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:49:02 -0400
Date: Thu, 27 Apr 2006 13:48:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/16] ehca: event queue
Message-ID: <20060427114828.GC32127@wohnheim.fh-wedel.de>
References: <4450A1AD.7040506@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A1AD.7040506@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:49:17 +0200, Heiko J Schick wrote:
>
> +     	ret = hipz_h_alloc_resource_eq(shca->ipz_hca_handle,

Indentation?

> +				       &eq->pf,
> +				       type,
> +				       length,
> +				       &eq->ipz_eq_handle,
> +				       &eq->length,
> +				       &nr_pages, &eq->ist);
> +
> +	if (ret != H_SUCCESS) {

Common convention is to return 0 on success and -ESOMETHING on eror.
You might want to follow that and remove H_SUCCESS from the complete
code.

> +		if (!(vpage = ipz_qpageit_get_inc(&eq->ipz_queue))) {

I personally despise assignments in conditionals.  Not sure if this is
documented in CodingStyle, but IME most kernel hackers tend to dislike
it as well.

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
