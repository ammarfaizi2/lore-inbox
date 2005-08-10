Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVHJHki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVHJHki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVHJHki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:40:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61647 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965032AbVHJHki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:40:38 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 10:40:37 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F9AF75.00005806@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, 

> +             return -EINVAL;
> +     if (!access_ok(VERIFY_WRITE, buf, size))
> +             return -EFAULT;
> +
> +     if (!(file->f_flags & O_LARGEFILE)) {
> +             if (*offset >= 0x7FFFFFFFull)
> +                     return -EFBIG;
> +             if (*offset + size > 0x7FFFFFFFull)
> +                     size = 0x7FFFFFFFull - *offset;

Please use a constant instead for 0x7FFFFFFFull. (Appears in various other 
places as well.) 

                                   Pekka 

