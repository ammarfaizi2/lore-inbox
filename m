Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWHRMco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWHRMco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWHRMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:32:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22134 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932447AbWHRMcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:32:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RQnNCkYa+96lDUOarSbYHBhasDRGKB9u8j5KPlF6i16Nd6aeyoXty+gyPH1XjFtM+7/DZnOGDT6NIDHy3JJT/DuyAIKQr5/GqSKtXG7nQ9fmfqSe6raT0mUAiTqT+9L+bSQPzt3xHjIyThJL3+oKQdo6BWrW7u1AZOVxmVL/ti0=
Message-ID: <d120d5000608180532j453bf0f3l2ee88b0502c20cfd@mail.gmail.com>
Date: Fri, 18 Aug 2006 08:32:41 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: cdev documentation (was Drop second arg of unregister_chrdev())
Cc: "Jonathan Corbet" <corbet@lwn.net>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200608180915.28763.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060817212248.19853.qmail@lwn.net>
	 <200608180915.28763.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> While I was sneaking around in the code I found this drivers/char/tty_io:3093
>
>        cdev_init(&driver->cdev, &tty_fops);
>        driver->cdev.owner = driver->owner;
>        error = cdev_add(&driver->cdev, dev, driver->num);
>        if (error) {
>                cdev_del(&driver->cdev);
>
> Isn't the call to cdev_del() just wrong here?
>

Yes, itlooks like it shouldjust be removed.

-- 
Dmitry
