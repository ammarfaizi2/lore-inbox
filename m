Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVHBUOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVHBUOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVHBUOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:14:33 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:25524 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261739AbVHBUOb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:14:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5BAfADazAC0avlZgNXcFl6TQrD7wwGtpHKWHMmOkm2dlsWyI+MuPQcalsauGeyhP06Rhi7Bl7pZ4Iuk9Wt4x8l4+DsUd3BTcIljKNMW/UewTP4L/gsVLLCoJW0kORMNsUtFyAzw6e1qGjdqg7EG/ZLPyEJhddOZZD6BLQ807Co=
Message-ID: <2ac89c700508021314f42da6a@mail.gmail.com>
Date: Wed, 3 Aug 2005 00:14:29 +0400
From: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Reply-To: Dmitrij Bogush <dmitrij.bogush@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: Touchpad errors
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050802072256a4d7ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EF633B.6080209@blueyonder.co.uk>
	 <d120d500050802072256a4d7ee@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I have the same issue on Acer Aspire 1520 notebook. On SuSE 9.3 system
can not boot with acpi=off.
In 2.6.13-rc4-git4 this crazy touchpad jumps reports as:

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip handler_IRQ_event+0x20/0x60

and sometimes I can see 

psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte N 

This happens when some software check battery state or current cpu
rate too often.



2005/8/2, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On 8/2/05, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> > New SuSE 9.3 x86_64 install after HD crash. With 2.6.13-rc3 and up to
> > 2.6.13-rc4-git4. I can't remember seeing these errors for quite a long
> > time, thought they were fixed, perhaps there is a regression in recent
> > kernels.
> > It completely and rapidly fills up dmesg and /var/log/messages so I
> > can't get other stuff I need to see.
> > psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> >
> 
> Does it work with acpi=off?
> 
> --
> Dmitry
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
