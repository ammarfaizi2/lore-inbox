Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVGFOeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVGFOeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVGFOeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:34:12 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:54692 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262202AbVGFKKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jvzXSxnzQhIEmO8H5R4RcIpD9lKJqUGRjNmiD/DK5Y+LIrChiyW031OO2WQii/HTJbMQ3seLNwom/gn6kLrvZ6vQtsSDa0jpH41KrFY8jy+lyrEG/gFjelEwJPZijUl32nTaHjBrg5Nrqt6aWbkjbPZed+VCR+0ZqbnC1evz75E=
Message-ID: <84144f0205070603102167e721@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:10:36 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [32/48] Suspend2 2.1.9.8 for 2.6.12: 609-driver-model.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164423660@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164423660@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c
> --- 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c    1970-01-01 10:00:00.000000000 +1000
> +++ 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c    2005-07-05 23:54:31.000000000 +1000
> +static inline void free_local_buffer(void)
> +{
> +       if (page_buffer)
> +               free_pages((unsigned long) page_buffer, 0);

Use free_page(), please.
