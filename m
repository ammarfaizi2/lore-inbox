Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVBOW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVBOW0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVBOW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:26:00 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:63774 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261917AbVBOWZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:25:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EXR0O0B27Q5lGxbB6M5p7fcCwpL2t8xGoDjPg+2t5A18fQ7u0SpgqWEGa9UvUL1mVDhJtONBdiZuCY4FZLZ+N1XDyccF4FUKzdzh7fMEE0hwcP+PGC07hqPRzxBsDZGB9iqVkj8V7wstuECwHnebqXdbUO3iMsJvztcxaM7+pRg=
Message-ID: <d120d50005021514251492dd10@mail.gmail.com>
Date: Tue, 15 Feb 2005 17:25:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] add "bus" symlink to class/block devices
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20050215220406.GA1419@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050215205344.GA1207@vrfy.org> <20050215220406.GA1419@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 23:04:06 +0100, Kay Sievers <kay.sievers@vrfy.org> wrote:
> 
> -static int class_device_dev_link(struct class_device * class_dev)
> -{
> -       if (class_dev->dev)
> -               return sysfs_create_link(&class_dev->kobj,
> -                                        &class_dev->dev->kobj, "device");
> -       return 0;
> -}
> -
> -static void class_device_dev_unlink(struct class_device * class_dev)
> -{
> -       sysfs_remove_link(&class_dev->kobj, "device");
> -}
> -

Hi,

I can agree on dropping driver link but I think that the link to
underlying real device is still needed.

-- 
Dmitry
