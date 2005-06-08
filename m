Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFHQV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFHQV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFHQJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:09:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:34953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261355AbVFHQC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:02:56 -0400
Date: Wed, 8 Jun 2005 09:02:44 -0700
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Abhay Salunke <Abhay_Salunke@dell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, matt_domsch@dell.com,
       Manuel Estrada Sainz <ranty@debian.org>
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Message-ID: <20050608160244.GA1122@kroah.com>
References: <20050608151744.GA12180@littleblue.us.dell.com> <d120d50005060808565a7944f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005060808565a7944f2@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 10:56:19AM -0500, Dmitry Torokhov wrote:
> On 6/8/05, Abhay Salunke <Abhay_Salunke@dell.com> wrote:
> > @@ -364,6 +364,7 @@ fw_setup_class_device(struct firmware *f
> >                printk(KERN_ERR "%s: class_device_create_file failed\n",
> >                       __FUNCTION__);
> >                goto error_unreg;
> > +r
> 
> What is this?

Proof he didn't test the code :(

> I think it would be better if you just have request_firmware and
> request_firmware_nowait accept timeout parameter that would override
> default timeout in firmware_class. 0 would mean use default,
> MAX_SCHED_TIMEOUT - wait indefinitely.

Yes and no.  Yes in that we should have a timeout value.  No in that 0
should be "forever" and we #define the current 10 second value.

thanks,

greg k-h
