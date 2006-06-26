Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWFZLtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWFZLtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWFZLtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:49:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750768AbWFZLtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:49:24 -0400
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86-64] ioctl32 for USB
References: <20060626113037.GA6265@attika.ath.cx>
From: Andi Kleen <ak@suse.de>
Date: 26 Jun 2006 13:49:22 +0200
In-Reply-To: <20060626113037.GA6265@attika.ath.cx>
Message-ID: <p738xnkuofx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piotr Kaczuba <pepe@attika.ath.cx> writes:

> Hello!
> 
> I'm running a 64-bit kernel and 32-bit userspace. There seems to be some
> unimplemented compability ioctls regarding USB. Dmesg shows the
> following:
> 
> [184966.543022] ioctl32(hald-probe-hidd:10760): Unknown cmd fd(4)
> cmd(81004806){01} arg(ffb52dd0) on /dev/usb/hiddev0
> 
> and
> 
> [50974.410204] ioctl32(vmware-vmx:3470): Unknown cmd fd(140)
> cmd(40109980){00} arg(ffb551a0) on /proc/bus/usb/002/001
> 
> Have it been only forgotten or are there other more serious reasons that
> these ioctls are missing?

Some of the USB ioctls were basically impossible to compat due to
broken design. Maybe it's now possible with is_compat_task,
but would be still extremly ugly.

-Andi
