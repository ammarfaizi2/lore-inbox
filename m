Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVEaQZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEaQZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEaQTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:19:01 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:11952 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261942AbVEaQMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:12:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:reply-to;
        b=ioyZnlSIjunHV5L7NWXaEKJXBjajUl0E/ID2CJLhED+BbIjZVgJLdQX+afi+YVZx3PLUGAz2oBtwXMX8XDBC6ZLc/4h/aijGRa48KB5rNdaZxL9UMo6U3lPAU4NgmvGIuntDvFBBVHIyA/ok3CAG+QpbtGW/MqEE/puXRRhvLp4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: spereira@tusc.com.au
Subject: Re: x25-selective-sub-address-matching-with.patch added to -mm tree
Date: Tue, 31 May 2005 20:14:28 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200505310933.j4V9XiiS009653@shell0.pdx.osdl.net>
In-Reply-To: <200505310933.j4V9XiiS009653@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505312014.30408.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 13:32, akpm@osdl.org wrote:
> x25: selective sub-address matching with call user data

> --- 25/net/x25/af_x25.c~x25-selective-sub-address-matching-with
> +++ 25-akpm/net/x25/af_x25.c

> @@ -1325,6 +1331,23 @@ static int x25_ioctl(struct socket *sock

> +		case SIOCX25SCUDMATCHLEN: {
> +			struct x25_subaddr sub_addr;

> +			if (copy_from_user(&sub_addr, argp,
> +					sizeof(&sub_addr)))
					      ^^^

You want sizeof(sub_addr) here. If other people won't NAKYAIOCTL.
