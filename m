Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWFBC6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFBC6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFBC6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:58:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:33490 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751165AbWFBC6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:58:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8NYQPHfzXNE90pv2vsukxDokHXDxt9lV+gKR8hCMTKJQDAbGwOlRs/qkb6vse1tF/zh2RMQJQ15eXolQrS0VTXGJSn7OAUe+W64gJ+BLwV3b73KcR04j84EDsXN1bLBZmhxynSZYjDpMukELN6/8FGCXC/hmfO0Kgd0oxg18t4=
Message-ID: <9e4733910606011958k5906117cl9ca18ddbaf9c3cc5@mail.gmail.com>
Date: Thu, 1 Jun 2006 22:58:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Ondrej Zajicek" <santiago@mail.cz>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200606012234.31566.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
	 <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
	 <200606012234.31566.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> VT switch to a VT where X is running. X will still require a VT and assume it
> has good access to the graphics system. While currently it has no problems,
> when drmcon becomes a reality there will have to be a state switch between
> the consoles settings and the setting for the VT running X.


> > > 14) backwards compatible, an old X server should still run on a new
> > > kernel. I will allow for new options to be enabled at run-time so that
> > > this isn't possible, but just booting a kernel and starting X should
> > > work.
> >
> > I'm not sure we want to continue supporting every X server released in
> > the last 25 years. But we should definitely support any X server
> > released in a 2.6 based kernel distribution. What are reasonable
> > limits?
>
> This is not a supportable position, Jon. I haven't seen it myself, but I'm
> willing to bet there are still a few systems out there running X5 but have a
> recent kernel. Since X version prior to 6 are no longer in wide use, however,
> this is something that could be done with little damage to anyone.
>
> But it still breaks the spirit of Linus' directive to "break nothing"

I don't know if break nothing applies to operating systems
masquerading as applications. "Break nothing" works both ways. Old X
servers are doing things like messing with the PCI bus that breaks new
kernels.

Use some common sense here, who would update to a 2006 kernel and keep
running an X server from 1989? Pick a reasonable limit and say the
rest are unsupported. Why make a pile of work for yourself that no
sane person is ever going to make use of.

Remember, an X server from 1989 only contains drivers for hardware
from 1989 and earlier. Can 2.6 Linux boot on a 1989 PC with an 8514
graphics card? Does it support running in 640K with an AboveBoard?
Does anyone even remember what an AboveBoard did?

-- 
Jon Smirl
jonsmirl@gmail.com
