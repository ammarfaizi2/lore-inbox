Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVGEQZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVGEQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVGEQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:24:24 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:45542 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261935AbVGEQSX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:18:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Koo6cx11gLGR7Sjd5U3rL8JPDXODNZ+aJAEim/SNxIbFPyDqcz9UwoK/vqswt2CccGWhdHM774TX5Q/lJ5/mqI1MJGHS+LrUEmyT2jMnIAnAuMpe6bqMM/RdF5r87txRHMy53TOB1+m3pZaetBgeSmOB/T47AWFqR1HCWdtLlGk=
Message-ID: <d120d50005070509186bd3cdb1@mail.gmail.com>
Date: Tue, 5 Jul 2005 11:18:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: davide vecchio <davide.vecchio@gmail.com>
Subject: Re: Problem with PS/2 Logitech WheelMouse
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <465e1cd305070508442be8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <465e1cd305070508442be8af@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/05, davide vecchio <davide.vecchio@gmail.com> wrote:
> Hi everybody,
> I'm running SOME LINUX DISTROS (Fedora Core 2 kernel 2.6.7 and, Suse
> 9.3 kernel 2.6.10-4) on an  Amd XP 1200 box on an msi 6360 MAINBOARD.
> I'm using a PS/2 Logitech WheelMouse (usb mouse connected using ps2 adapter).
> I'm experiencing on both distros that with the standard kernel (the
> one prebuilt coming with the distro), the mouse is working correctly
> but when I tried to compile a new kernel (2.6.11 or 2.6.22) got from
> the kernel.org site both using modules or static support for the mouse
> , the mouse stops working both in console (tested throught cat
> /dev/input/mice) and in X.
> 

Hi,

I see that the mouse seem to be detected properly... I wonder if some
of the extended probes confuse it. Could you try doing:

         rmmod psmouse
         insmod /lib/modules/`uname
-r`/kernel/drivers/input/mouse/psmouse.ko proto=bare

and 

         rmmod psmouse
         insmod /lib/modules/`uname
-r`/kernel/drivers/input/mouse/psmouse.ko proto=imps

And tell me if any of them work?

Thanks!

-- 
Dmitry
