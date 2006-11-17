Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933752AbWKQRxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933752AbWKQRxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933750AbWKQRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:52:59 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9688 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S933753AbWKQRw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:52:58 -0500
Message-ID: <455DF70C.7090400@pathscale.com>
Date: Fri, 17 Nov 2006 09:53:16 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 02/13] Device Discovery and ULLD Linkage
References: <20061116035826.22635.61230.stgit@dell3.ogc.int> <20061116035837.22635.13571.stgit@dell3.ogc.int>
In-Reply-To: <20061116035837.22635.13571.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:

> +static inline void *vzmalloc(int size)
> +{
> +	void *p = vmalloc(size);
> +	memset(p, 0, size);
> +	return p;
> +}

This isn't checking the return value from vmalloc.

Also, we could do with a generic vzalloc and vcalloc, just as we now 
have kzalloc and kcalloc.  There are lots of routines like this sitting 
around.

	<b
