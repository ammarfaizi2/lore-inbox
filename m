Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWC1UXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWC1UXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWC1UXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:23:03 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:24650 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbWC1UXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:23:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4/mp703lluTA9gpLAnFVKwZxWSZNhH5Wi0KBHO4ek42WRqqMJHz7Wff+H8LsY6+RgZ7us/09ZetiMf5rQ2gKS3EkuFwAo3cUHsZnxjZYzp2G/hH6tEj2vqflz3/emT5hJQZi4sR68xOkAmrZHTp81oXZ10hnCtlckDis6begmQ=
Message-ID: <d120d5000603281223p28792d7la7a13438a2a68149@mail.gmail.com>
Date: Tue, 28 Mar 2006 15:23:00 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Bodo Eggert" <7eggert@gmx.de>
Subject: Re: [BUG] PS/2-mouse not found in 2.6.16
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0603282044060.2538@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
	 <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com>
	 <Pine.LNX.4.58.0603282044060.2538@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Bodo Eggert <7eggert@gmx.de> wrote:
> On Mon, 27 Mar 2006, Dmitry Torokhov wrote:
> > On 3/27/06, Bodo Eggert <7eggert@gmx.de> wrote:
>
> > > With kernel 2.6.16, my Logitech mouse is no longer detected (not reported
> > > in dmesg, not working).
> > >
> >
> > Does it help if you comment out call to quirk_usb_handoff_ohci() (your
> > USB host controller is an OHCI one, isn't it?) in
> > drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff()?
>
> It's uhci, and turning
> drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff into a noop did not
> help.

OK, then please boot with i8042.debug=1 and post your full dmesg.

--
Dmitry
