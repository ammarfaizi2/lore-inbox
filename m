Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVGLWVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVGLWVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVGLWTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:19:30 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:24821 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262399AbVGLWSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:18:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qBN4p1q2DW+KzsQTBfwnO72SSpNMtppmWQt2rYnZnvn6TPUv6t1Ge0eHQWnABqp4I4fQeJvzFbFSvnkpNF01au14xtuDX7HMe9wsAzSevdWBTBZWFlP91yl/uEBLZnmWb7rw+7UHCmB1l/O/qRQZWeGxRiyzJEJc6Q63M0O68tk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] Runtime fix for intermodule.c
Date: Wed, 13 Jul 2005 02:25:31 +0400
User-Agent: KMail/1.8.1
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20050712213920.GA9714@physik.fu-berlin.de>
In-Reply-To: <20050712213920.GA9714@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507130225.31840.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 01:39, Adrian Glaubitz wrote:
> This little patch adds the missing function declaration
> of the deprecatated function call inter_module_get
> to the header file include/linux/module.h and the
> necessary EXPORT_SYMBOL to kernel/intermodule.c. Without
> the declaration and the EXPORT_SYMBOL any module that requires
> the inter_module_get call will fail upon loading
> since the symbol inter_module_get cannot be resolved,
> applying this patch will make those modules work again.

> Affected modules are for example the ltmodem drivers
> version 8.31a8 for lucent chipsets, they won't
> work without the fix.

Just to be sure I read what I read: you are asking for reexport of a function
that was officially deprecated 9 months ago on the grounds that said reexport
would be useful for a crappy [1] proprietary module?

[1] Semi-randomly freezing serial mouse after loading.
