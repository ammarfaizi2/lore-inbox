Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVJLWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJLWAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJLWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:00:13 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:21165 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932462AbVJLWAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:00:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9i6dIE6VLMismfL9ai7mbjyjJGzy4aQFuWiYgcsuQKpKD06/KhfeY0nVo+LTpRVbcDiEeBuQwLE0CS3RyuK5DKWYQTNupI1lK9qhhGLiRQcQIxfYONLd9KHcY3iLg3oeGqpQDcyMdqVxE+Une54XeKpY+pIjUY4BPgEh5Dzu5w=
Message-ID: <d120d5000510111434m2951b895p893e93bafef0f8e7@mail.gmail.com>
Date: Tue, 11 Oct 2005 16:34:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Crocombe <rwcrocombe@raytheon.com>
Subject: Re: PS/2 Keyboard under 2.6.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <434C29D9.8000603@raytheon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <434B121A.3000705@raytheon.com> <434B3C82.5080409@m1k.net>
	 <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>
	 <200510110042.13325.dtor_core@ameritech.net>
	 <434C21F4.7090806@raytheon.com>
	 <d120d5000510111353paf02994ta3bd815428f228d2@mail.gmail.com>
	 <434C29D9.8000603@raytheon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Robert Crocombe <rwcrocombe@raytheon.com> wrote:
> Dmitry Torokhov wrote:
> > On 10/11/05, Robert Crocombe <rwcrocombe@raytheon.com> wrote:
> >
> >>Dmitry Torokhov wrote:
> >>
> >>>It is "usb-handoff", not "usb=handoff". It instructs BIOS to disable USB
> >>>Legacy emulation mode which turns USB keyboard/mouse into emulated PS/2
> >>>devices...
> >>
> >>No effect.
> >>
> >
> >
> > What about "i8042.noacpi"? Could you please send me your dmesg?
>
> (Added LKML back in... Oops)
>
> Using i8042.noacpi made the machine sad:
>

Well, it died deep in SCSI core so I doubt i8042.noacpi made it do it.

OK, having finally read your .config :) :

#
# Hardware I/O ports
#
CONFIG_SERIO=m
CONFIG_SERIO_I8042=y

Please make serio core compiled in instead of being a module and also
make sure that you load atkbd module (or make it built-in as well).

--
Dmitry
