Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVGGRJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVGGRJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGGRJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:09:24 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:26485 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261399AbVGGRHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:07:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dX8EKp+YMVnpt9U1COCNTKzParNrvTpY5Bgx74PDMBEbfvEQ4cZ7h6/IjsjuThNRiA1ZxzHiSWRV8pLWdNjkvW3t7hJSkgRpM7FnyOjMShruYh8QKTL8JuX++BvWMstYo/NMC0qJqdxmwXeeRUYvJVOCQ7N8x4tlUyHbE2T+rd8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: domen@coderock.org
Subject: Re: [patch 4/5] autoparam: af_unix workaround
Date: Thu, 7 Jul 2005 21:13:41 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, damm@opensource.se
References: <20050707112551.331553000@homer> <20050707112636.875741000@homer>
In-Reply-To: <20050707112636.875741000@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072113.41716.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 15:25, domen@coderock.org wrote:
> This is a quick fix that removes the "KBUILD_MODNAME -> unix -> 1" conflict.

> --- a.orig/net/unix/af_unix.c
> +++ a/net/unix/af_unix.c

> +#undef unix

This deserves a comment. Ditto for ide workarounds.

>  module_init(af_unix_init);
>  module_exit(af_unix_exit);
