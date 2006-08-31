Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWHaSlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWHaSlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWHaSlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:41:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:36450 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932313AbWHaSlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3sqvqHrH33s3V+wgLfXdpyl7sTX7hxr776A//KZtLWDIvxu8IUVcNz8DJ9sbRjNy9PkSrsZhAchA8r12LM1M4uFJ3WcLFtumr6xkkz5mxTgbkoyvMLH/4MCkcEXfJ58cZt3TSyoSx9e0aUilxiB57uX4K4+fJ2VIxmajZqvpAE=
Message-ID: <1defaf580608311141j39aa87e5ldf80db1db54b2edf@mail.gmail.com>
Date: Thu, 31 Aug 2006 20:41:04 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [RFC][PATCH 2/9] conditionally define generic get_order() (ARCH_HAS_GET_ORDER)
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060830221605.CFC342D7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060830221604.E7320C0F@localhost.localdomain>
	 <20060830221605.CFC342D7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/06, Dave Hansen <haveblue@us.ibm.com> wrote:
> diff -puN mm/Kconfig~generic-get_order mm/Kconfig
> --- threadalloc/mm/Kconfig~generic-get_order    2006-08-30 15:14:56.000000000 -0700
> +++ threadalloc-dave/mm/Kconfig 2006-08-30 15:15:00.000000000 -0700
> @@ -1,3 +1,7 @@
> +config ARCH_HAVE_GET_ORDER
> +       def_bool y
> +       depends on IA64 || PPC32 || XTENSA
> +

I have a feeling this has been discussed before, but wouldn't it be
better to let each architecture define this in its own Kconfig?

At some point, I have to add AVR32 to that list, and if one or more
other architectures need to do the same, there will be rejects.

Haavard
