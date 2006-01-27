Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWA0IP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWA0IP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWA0IP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:15:28 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:61683 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932418AbWA0IP0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BG2uiI6/vFRJ9cwJq4vjnb8riUicwNZbfHrT0r/G+/9Q5y0mrNJbeK5aqleAeyIMR2tuHYntlWs4sl+tY7u9o3A9BrWO1hlmuCarg8+qP1Bs0iXWpZuspNKiejnb1nfajqIJVn0CZPuOf7lzUIf2Z4/T7QNm3xs1TII3gSfbeZ4=
Message-ID: <aec7e5c30601270015j5a2d5409p9e886987b31f611e@mail.gmail.com>
Date: Fri, 27 Jan 2006 17:15:24 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: netboot broken ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D9C8C5.3020902@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D9C8C5.3020902@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/06, Knut Petersen <Knut_Petersen@t-online.de> wrote:
> Hi everybody!
>
> I spent too many hours trying to boot a machine via ethernet.
> The nic includes a pxe boot rom, and without any problems I
> manage to boot an old DOS disk image and memtest.
>
> There are also no problems to _load_ the linux kernel.
>
> But when it reaches the point of ip autoconfiguration
> (I included ip=dhcp on the kernel command line and, of course,
> I enabled dhcp autoconfiguration in the .config), nothing works.
> It sends dhcp requests, dhcpd answers, and this repeats forever.
> Well ... this is the second time dhcpd is asked ... without a
> working and basically correct configured dhcpd the pxe boot
> rom and pxelinux would have been unable to  load the kernel ?!

Maybe the kernel device driver doesn't work as expected compared to
the PXE driver. I've heard that the other way around is more likely
though. =) Or maybe the PXE driver does half duplex communication only
but the Linux driver is more advanced and supports full duplex, which
fails for some reason.

Check the duplex, try using a good old hub to force half duplex communication.

Or maybe it is an issue with your DHCP server?

> I tried a number of recent kernels, the oldest was 2.6.14.
>
> Any ideas? Can anybody please
>  - confirm that network booting does still work
>  - confirm that it is broken.

I'm netbooting 2.6.15 (ip=on kernel command line) and it works fine for me.

/ magnus
