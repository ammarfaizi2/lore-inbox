Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWGaAIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWGaAIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGaAIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:08:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:29343 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932354AbWGaAIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:08:24 -0400
Date: Sun, 30 Jul 2006 17:03:59 -0700
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060731000359.GB23220@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060727125655.f5f443ea.akpm@osdl.org> <20060727201255.GA9515@suse.de> <200607281033.06111.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <44CCBBC7.3070801@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CCBBC7.3070801@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 04:01:43PM +0200, Laurent Riffard wrote:
> In this situation, udev (version 096 here) is unable to create these
> device files (/dev/full, /dev/kmem, /dev/kmsg, etc.). /dev/null does
> exist (with wrong permissions) because it has been created by the
> initrd script.

Something's really broken with that version of udev then, because the
094 version I have running here works just fine with these symlinks.

> In order to get back the device files, I have to run the following
> command:
> # for f in /sys/class/mem/*/uevent; do echo 1 > $f; done

Ah, ok, it sounds like it's not a bug in udev itself, but rather a bug
in the way your distro does it's initialization of udev, at boot.  I
suggest you file a bug with them, as they are known for doing this a bit
differently than any other distro (and different from how the udev
developers recommend), so they can fix it.  It's probably just a shell
script issue.

thanks,

greg k-h
