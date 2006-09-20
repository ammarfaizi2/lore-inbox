Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWITNWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWITNWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWITNWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:22:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:55774 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751257AbWITNWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:22:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tH6kGwm0aNRIVmRet4YUfY+0WAnGJD0kbGEc+ztSafSVHs1BtoLox2d/bWYaosabKt/Ltxyjc1X25HFp3Ho9ipNMogXIzLVTo19XEPXlYexAkNSOKc8CeXKUWL1S1ts5xuUz9bAr812BaYOW4tVv2Elks0ki4EPlEw8si1/Bj9A=
Message-ID: <d120d5000609200622g333f2767y27e529d81333e7b7@mail.gmail.com>
Date: Wed, 20 Sep 2006 09:22:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Lennart Poettering" <mzxreary@0pointer.de>
Subject: Re: [PATCH] input: A few new KEY_xxx definitions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060808100744.GA16201@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808000925.GA6220@curacao>
	 <200608072219.02315.dtor@insightbb.com>
	 <20060808100744.GA16201@tango.0pointer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Lennart Poettering <mzxreary@0pointer.de> wrote:
> On Mon, 07.08.06 22:19, Dmitry Torokhov (dtor@insightbb.com) wrote:
>
> > > KEY_POWERPLUG, KEY_POWERUNPLUG:
> > >
> > >     Some laptops generate a fake key event when the power cord is
> > >     plugged or unplugged. (Notably MSI laptops, such as S270)
> > >
> >
> > How do these events get delivered? Are you saying that atkbd reports
> > key presses when pulling out AC cord?
>
> Yes, exactly.
>

Lennart,

I applied part of the patch defining KEY_BLUETOOTH and KEY_WLAN, but I
did not apply KEY_POWER[UN]PLUG. I feel that these should not be
defined as KEY_* events but (if we decide that they should be reported
through input layer) as EV_PWR events.

-- 
Dmitry
