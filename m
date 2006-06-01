Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWFARKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWFARKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWFARKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:10:25 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:162 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964915AbWFARKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:10:24 -0400
Date: Thu, 1 Jun 2006 07:59:22 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Smirl <jonsmirl@gmail.com>
cc: Ondrej Zajicek <santiago@mail.cz>, "D. Hazelton" <dhazelton@enter.net>,
       Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> 
 <200605302314.25957.dhazelton@enter.net>  <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
  <200605310026.01610.dhazelton@enter.net>  <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
  <20060601092807.GA7111@localhost.localdomain>
 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, Jon Smirl wrote:

> 1) The kernel subsystem should be agnostic of the display server. The
> solution should not be X specific. Any display system should be able
> to use it, SDL, Y Windows, Fresco, etc...
>
> 2) State inside the hardware is maintained by a single driver. No
> hooks for state swapping (ie, save your state, now I'll load mine,
> ...).
>
> 3) A non-root user can control their graphics device.
>
> 4) Multiple independent users should work
>
> 5) The system needs to be robust. Daemons can be killed by the OOM
> mechanism, you don't want to lose your console in the middle of trying
> to fix a problem. This also means that you have to be able to display
> printk's from inside interrupt handles.
>
> 6) Things like panics should be visible no matter what is running. No
> more silent deaths.
>
> 7) Obviously part of this is going to exist in user space since some
> cards can only be controlled by VBIOS calls. Has anyone explored using
> the in-kernel protected mode VESA hooks for this?
>
> 8) The user space fbdev API has to be maintained for legacy apps. DRM
> can be changed if needed since there is only a single user of it, but
> there is no obvious need to change it.
>
> 9) there needs to be a way to control the mode on each head, merged fb
> should also work. Monitor hotplug should work. Video card hot plug
> should work. These should all work for console and the display
> servers.
>
> 10) Console support for complex scripts should get consideration.
>
> 11) VGA is x86 specific. Solutions have to work on all architectures.
> That implies that the code needed to get a basic console up needs to
> fit on initramfs. Use PPC machines as an example.
>
> 12) If a driver system is loaded is has to inform the kernel of what
> resources it is using.
>

13) for hardware that supports it a text mode should be supported

David Lang
