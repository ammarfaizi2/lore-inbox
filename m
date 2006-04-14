Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWDNONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWDNONE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWDNOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:13:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:52866 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751244AbWDNONB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:13:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Heimanns <ch.heimanns@gmx.de>
Subject: Re: Suspend to disk
Date: Fri, 14 Apr 2006 16:11:50 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz
References: <443C0C2D.1020207@gmx.de> <200604112238.07166.rjw@sisk.pl> <443F86EB.8060903@gmx.de>
In-Reply-To: <443F86EB.8060903@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141611.50740.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 13:26, Christian Heimanns wrote:
> Sorry for the delay, I was on the road...
> 
> Rafael J. Wysocki wrote:
> > [update]
> > 
> > On Tuesday 11 April 2006 22:35, Rafael J. Wysocki wrote:
> >> On Tuesday 11 April 2006 22:06, Christian Heimanns wrote:
> >>> Hello to all,
> >>> following situation:
> >>> On my notebook Samsung X20 1730V I'm running Slackware 10.2 current with
> >>> kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
> >>> Since kernel >= 2.6.16 suspend to disk breaks the restore of the
> >>> X-Server. That means that the current sessions is lost and the X-Server
> >>> restarts.
> >> Does it resume successfully without X (ie. runlevel 3)?
> >>
> >>> No problems with suspend to RAM. Please find attached the 
> >>> dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
> >>> output frpm lspci. The only difference I can find is that I have with
> >>> kernel 2.6.16 some
> >> Do you use a framebuffer driver and if so, is it modular?
> > 
> > Sorry, I see in the logs that you do.  Could you please boot with vga=normal
> > and see if that helps?
> > 
> 
> I tried kernel 2.6.16.2 with vga=normal. No changes. Suspend to RAM
> works well, suspend to disk not. It's just the X-Server who restarts and
>  I lose the suspended X-session. The following messages I've found in
> the dmesg output after resume:
> 
> pnp: Device 00:08 does not supported activation.
> pnp: Device 00:09 does not supported activation.
> Restarting tasks... done
> 
> No idea what pnp device 00:08 and 00:09 is!

No idea, sorry.

> These problems I have only with the kernel >= 2.6.16

You can try to do something like this: change the runlevel to 3 (eg. init 3),
the start the X server manually (ie. "X" as root), switch to a text terminal
and try to suspend.  Then, after resume, see if the X server is still running
and if not, look into its log.

Greetings,
Rafael
