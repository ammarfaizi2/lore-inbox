Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVBUR1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVBUR1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVBUR1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:27:18 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:364 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262045AbVBUR1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:27:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EMSl66t6f4YGWOzGH8icFRxIlkxs7F6LKNq3r3xZXJa6N7raOYWoIHMx5hsMiE/1O1j649wV2qe0yZKNGTDuMF7hs65kbcAKgAWeQ87CjAEoO0gOBRsZqp3H26beKSdVIDZn5QZsPg7ahu/U3PbZVrAjAdBAdsqJwodo2m/mH5c=
Message-ID: <9e47339105022109276261e845@mail.gmail.com>
Date: Mon, 21 Feb 2005 12:27:13 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <421A142A.1060302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
	 <421A142A.1060302@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 12:02:34 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jon Smirl wrote:
> > On Mon, 21 Feb 2005 03:37:45 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>You either need to execute the video BIOS to initialize the hardware
> >>registers, or initialize the hardware registers themselves.
> >
> >
> > That is what the user mode reset program does.
> >
> > The problem is, how do I get it to run before calling the device's
> > probe function? Most of the framebuffer drivers assume that the
> > hardware has already been reset in their probe code.
> 
> <shrug>  You do precisely what you just said:  run it before the
> device's probe function.
> 
> That typically means either initramfs addition or using 'install
> <module> command...' in /etc/modprobe.conf.

How does install module work if one driver is servicing several adapters?
What if one adapater is in the card at boot and another shows up via hotplug?

> 
>         Jeff
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
