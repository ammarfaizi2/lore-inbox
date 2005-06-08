Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFHQNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFHQNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFHQLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:11:52 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:65092 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261375AbVFHQJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:09:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fSJV5aguxG9mffcfGxpvzCr6A/RMAWTce2zO115I7rnIC+V1rsxR0bFiqEJR72ETdcsgBpbBNfmu758QGkQh8oguk2NrqSKhXaN5gGgpgTWUzKFaOz64pM1NDyDlT4emS4gcWJsPw6y2OqatGUTye/KQZ8BReB3I+MqbXiV9/Xo=
Message-ID: <d120d5000506080909c17e973@mail.gmail.com>
Date: Wed, 8 Jun 2005 11:09:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Cc: Abhay Salunke <Abhay_Salunke@dell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, matt_domsch@dell.com,
       Manuel Estrada Sainz <ranty@debian.org>
In-Reply-To: <20050608160244.GA1122@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050608151744.GA12180@littleblue.us.dell.com>
	 <d120d50005060808565a7944f2@mail.gmail.com>
	 <20050608160244.GA1122@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Jun 08, 2005 at 10:56:19AM -0500, Dmitry Torokhov wrote:
> > On 6/8/05, Abhay Salunke <Abhay_Salunke@dell.com> wrote:
> > > @@ -364,6 +364,7 @@ fw_setup_class_device(struct firmware *f
> > >                printk(KERN_ERR "%s: class_device_create_file failed\n",
> > >                       __FUNCTION__);
> > >                goto error_unreg;
> > > +r
> >
> > What is this?
> 
> Proof he didn't test the code :(
> 
> > I think it would be better if you just have request_firmware and
> > request_firmware_nowait accept timeout parameter that would override
> > default timeout in firmware_class. 0 would mean use default,
> > MAX_SCHED_TIMEOUT - wait indefinitely.
> 
> Yes and no.  Yes in that we should have a timeout value.  No in that 0
> should be "forever" and we #define the current 10 second value.
> 

Are you saying that we should rip out of the firmware_class current
timeout attribute? I thought it was a nice to have system-wide defult
that can be adjusted by operator w/o need to recompile anything.

-- 
Dmitry
