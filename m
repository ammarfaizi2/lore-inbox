Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUJPBud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUJPBud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 21:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUJPBud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 21:50:33 -0400
Received: from smtp-out.hotpop.com ([38.113.3.51]:11663 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268532AbUJPBuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 21:50:20 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 09:50:32 +0800
User-Agent: KMail/1.5.4
Cc: Kendall Bennett <kendallb@scitechsoft.com>, linux-kernel@vger.kernel.org,
       penguinppc-team@lists.penguinppc.org,
       linux-fbdev-devel@lists.sourceforge.net
References: <416E6ADC.3007.294DF20D@localhost> <200410160551.40635.adaplas@hotpop.com> <9e47339104101516206c8597d3@mail.gmail.com>
In-Reply-To: <9e47339104101516206c8597d3@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410160946.32644.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 October 2004 07:20, Jon Smirl wrote:
> On Sat, 16 Oct 2004 05:51:38 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > Yes, that is the downside to a userspace solution. How bad will that be?
> > Note that Jon Smirl is proposing a temporary console driver for early
> > boot messages until the primary console driver activates.
>
> Does anyone know exactly how big the window is from when a compiled in
> console activates until one that relies on initramfs loads? I don't
> think it is very big given that a lot of the early printk's are queued
> before they are displayed.

There's a log of initialization that goes on between console_init() and
populate_rootfs().  However, console_init() will only initialize built-in
consoles (as pointed to by conswitchp) such as vgacon or dummycon.
However, the framebuffer system initialization does happen after
populate_rootfs().  

So, at least in the framebuffer perspective, the emulator/video boot may be
loaded as part of initramfs.

Tony


