Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVGFN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVGFN5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVGFN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 09:57:42 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:36633 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVGFKD3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:03:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b29erHUk/6JXsqPuvAQpGEEAjDxehxb4q/hsZdfWWQsHM3kXu170A9BD8mg2K5CbaS49PTsoVHFGv7w7JMQlPAsmr57NUzRnDPo16FStmzt5hQJ3SIOonBqBQXCIuPtjT+zceJqzElFxXB/EMtpq/ikBcYJXkPfhr4eAx4qEtXM=
Message-ID: <84144f02050706030316111116@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:03:28 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [41/48] Suspend2 2.1.9.8 for 2.6.12: 617-proc.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1120616443979@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <1120616443979@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 618-core.patch-old/kernel/power/suspend2_core/suspend.c 618-core.patch-new/kernel/power/suspend2_core/suspend.c
> --- 618-core.patch-old/kernel/power/suspend2_core/suspend.c     1970-01-01
> +#define SNPRINTF(a...)         len += suspend_snprintf(debug_info_buffer + len, \
> +               PAGE_SIZE - len - 1, ## a)

Please don't introduce subsystem specific wrappers for generic string
manipulation functions. Put them to lib/.

                      Pekka
