Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGaRhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGaRhI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVGaRhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:37:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261795AbVGaRhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:37:05 -0400
Date: Sun, 31 Jul 2005 10:35:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-kernel@vger.kernel.org, stelian@popies.net, Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050731103528.4cb7f197.akpm@osdl.org>
In-Reply-To: <42ECC822.7060802@roarinelk.homelinux.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<42EC9410.8080107@roarinelk.homelinux.net>
	<20050731021628.42e3ab98.akpm@osdl.org>
	<42ECC822.7060802@roarinelk.homelinux.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
>
> Andrew Morton wrote:
> > Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> > 
> >>something broke the sonypi driver a bit after -mm2:
> >> I can no longer set bluetooth-power for instance, and it logs these
> >> messages:
> >>
> >> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
> >> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
> >> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
> >>
> >> setting/getting brightness, getting battery/ac status still work.
> >>
> > 
> > 
> > Can you do a `patch -p1 -R' of the below, see if it fixes it?  It probably
> > won't.
> > 
> > Also please test 2.6.13-rc4-mm1 which is missing the acpi tree...
> > 
> > Thanks.
> 
> 
> Found the cause:

Wonderful, thanks.   So does that mean that 2.6.13-rc4 doesn't work?

>  > -revert-gregkh-pci-pci-assign-unassigned-resources.patch
>  >
>  > Hopefully no longer needed
> 
> Applying this dropped patch to -rc3-mm3 and -rc4-mm1 fixes
> it.

OK, I'll bring it back again.
