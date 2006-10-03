Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWJCMzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWJCMzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWJCMzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:55:11 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:36581 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932090AbWJCMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:55:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kQAQDMOCKA5NPGdhocUqNYAR0f56cpRxWAE+AhIYWrJW0rGIXL/M1rQ6qcPkR4xUFxXY/I7GeS3KdqqTuzdnqduyHNZDH6TdcpcrSPKMAr7TkQl66ckbGRCS1mNmwsRZ9t2UFzsYcAu9PERp0n3YdwAPRvQMR/1FuPqvl4DQDs4=
Message-ID: <653402b90610030555h2536b04bs3603d95635b93ca7@mail.gmail.com>
Date: Tue, 3 Oct 2006 14:55:07 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: andrew.j.wade@gmail.com
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: akpm@osdl.org, "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Randy Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200610022006.45806.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	 <200610021449.08640.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <653402b90610021440h2e416394r55227ce5e7eb6171@mail.gmail.com>
	 <200610022006.45806.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Andrew James Wade <andrew.j.wade@gmail.com> wrote:
>
> I'm afraid not; it looks like my suggestion "LCD display" grates on
> people's ears. Simply calling the device an "LCD" is probably the
> best bet, and "LCD screen" would be better than "LCD monitor". Screens
> can be any size, it's a fairly generic term.
>
> The class name and directory name should probably include the word
> "display", but I don't know what the other part should be. What sort
> of displays should be included in this category, and what sort
> shouldn't?
>
> Andrew Wade
>

My first idea was call it "display", for small/medium screens of any
kind (LCD, OLED, FED, NED... whatever). I named it "drivers/display/",
so anyone who create a driver for a display or display controller can
put it there (creating a separator for its own category at Kconfig),
as there aren't so many of them for now.

But people said "display" could be so generic and cause confusion with
usual video drivers, so I renamed it to "drivers/lcddisplay/", as it
is more expressive (however when someone will create a OLED driver
will have to create a new folder...).

I would like to put any kind of display driver there (LCD, OLED...)
not just LCDs and name it "drivers/display". I think people won't
confuse them with VESA... as there aren't drivers for "screens", just
for video cards (logically). But some people don't agree.
