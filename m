Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbUC3TNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUC3TNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:13:08 -0500
Received: from 201008050033.user.veloxzone.com.br ([201.8.50.33]:55748 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263833AbUC3TM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:12:58 -0500
Date: Tue, 30 Mar 2004 16:12:56 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: rmmod deadlocks with 2.6.5-rc[2,3]
In-Reply-To: <406996C2.4030204@reactivated.net>
Message-ID: <Pine.LNX.4.58.0403301606180.352@pervalidus.dyndns.org>
References: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org>
 <406996C2.4030204@reactivated.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Daniel Drake wrote:

> Frédéric L. W. Meunier wrote:
> > If I boot with 2.6.5-rc[2,3] and use rmmod snd_via82xx or rmmod
> > ohci_hcd (it doesn't happen with all modules), rmmod deadlocks.
> > 2.6.4 works fine.
>
> The ohci_hcd problem should be temporarily fixed by a recent
> patch to this list, from Greg KH (subject: [PATCH] USB:
> Eliminate wait following interface unregistration). This
> worked for me.

I forgot to report that I don't need OHCI. It's hotplug which
loads it for some reason under 2.6, but not under 2.4.

> As for the snd_ modules, this is a different problem, which I
> am still experiencing. I have had it with both snd_emu10k1
> and snd_intel8x0 - but it does not happen every time. I have
> experienced it on 2.6.5-rc2 and -rc3 (plus their -mm
> patches). rmmod hangs and doesnt respond to kill -9.

I used ALSA from CVS.

> Is there any output I can capture to diagnose this?

Here nothing gets printed. Maybe strace can help. But I'll
wait.

It also happened removing i2c_isa when I went through removing
all modules. Nothing wrong with joydev, adi, gameport, it87...

-- 
http://www.pervalidus.net/contact.html
