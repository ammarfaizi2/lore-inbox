Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbSJFW0q>; Sun, 6 Oct 2002 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSJFW0q>; Sun, 6 Oct 2002 18:26:46 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:28457 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S262241AbSJFW0p>; Sun, 6 Oct 2002 18:26:45 -0400
Message-Id: <m17yJwh-006imUC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Mon, 7 Oct 2002 00:01:55 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco> <m17yAhF-006i5XC@Mail.ZEDAT.FU-Berlin.DE> <001601c26d5e$b7a20fc0$0a00a8c0@refresco>
In-Reply-To: <001601c26d5e$b7a20fc0$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 19:35, John Tyner wrote:
> > In vicam_v4l_open:
> >
> > Why is only the first control message checked for errors?
>
> The second one turns on the LED. I didn't check it because I figured the
> LED actually turning on was not a big deal. Though, I suppose that if an
> error occurred, that could be indicative of some other problem.
>

Exactly.

> > vicam_usb_probe:
> >
> > __devinit ???
> >
> > vicam_usb_disconnect:
> >
> > __devexit ???
>
> I'm not sure I see the problem here. __devinit is only defined when HOTPLUG
> is not defined, which seems right to me. If there is no HOTPLUG then we can
> throw away the code as soon as init is completed. ...similar argument for
> __devexit. Correct me if I'm wrong.

But usbcore will happily call probe if  HOTPLUG is not defined and AFAICT
usb will compile without HOTPLUG.

	Regards
		Oliver
