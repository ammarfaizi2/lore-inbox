Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVHDGja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVHDGja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVHDGja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:39:30 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:38205 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261871AbVHDGj3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:39:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WApPMe4H0XfPUpgv07JOEDqa/Go6th5H578prTxVUSoHDU5XdEXFcjfZklRGznWK0LFUG6SOu8b/s3/fTnkvr9zYyL6BhqQnzA9jdNJAeXWYmPZ6gGR0HTbRlY9iFm3nronIDvmHxZ+TRwEKaXifz4L3khDrVx/FW07JPWy6JsI=
Message-ID: <84144f020508032339565658a0@mail.gmail.com>
Date: Thu, 4 Aug 2005 09:39:25 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: youssef@ece.utexas.edu
Subject: Re: [PATCH][ACPI] toshiba_acpi.c: add check for NULL pointer
Cc: linux-kernel@vger.kernel.org, toshiba_acpi@memebeam.org
In-Reply-To: <Pine.LNX.4.61.0508040048190.14176@linux08.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0508040048190.14176@linux08.ece.utexas.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Hmamouche, Youssef <youssef@ece.utexas.edu> wrote:
> --- a/drivers/acpi/toshiba_acpi.c       2005-07-15 14:18:57.000000000 -0700
> +++ b/drivers/acpi/toshiba_acpi.c       2005-08-03 21:35:12.000000000 -0700
> @@ -263,6 +263,9 @@
>           * destination so that sscanf can be used on it safely.
>           */
>          tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
> +       if(tmp_buffer == NULL) {
> +               return -ENOMEM;
> +       }

Already fixed in 2.6.13-rc4-mm1.

                                  Pekka
