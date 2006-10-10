Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWJJN6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWJJN6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWJJN6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:23712 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWJJN6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:58:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PhTyn35+Hkk+ZykYRxbjnq0ADHa5vp1VZ1yK4om6ut7roBgPZ0fkKgWiGU6hKk6MQk2Mm5/YRi/Juc8/efDV/fPw1mUjz0aNkuNbwTPaQkzR5XiRiJmWy9xjJSwD5lv8m6VmHy1gMsb5xEHhF1jXZujn4fK/twO2BkoR2oUK7oY=
Message-ID: <d120d5000610100658l6d80c7c7p84d31da317d457dd@mail.gmail.com>
Date: Tue, 10 Oct 2006 09:58:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH] input: handle sysfs errors
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061010064939.GA21385@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010064939.GA21385@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Jeff Garzik <jeff@garzik.org> wrote:
>
> -       device_create_file(&serio->dev, &atkbd_attr_extra);
> -       device_create_file(&serio->dev, &atkbd_attr_scroll);
> -       device_create_file(&serio->dev, &atkbd_attr_set);
> -       device_create_file(&serio->dev, &atkbd_attr_softrepeat);
> -       device_create_file(&serio->dev, &atkbd_attr_softraw);
> +       err = device_create_file(&serio->dev, &atkbd_attr_extra);
> +       if (err) goto fail_serio;

I have a patch that converts atkbd to attribute group and also one
that handles errors from input_register_drevice. I will add sysfs
error checks there as well.

-- 
Dmitry
