Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTHOQDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTHOQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:03:20 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:19241
	"EHLO gaston") by vger.kernel.org with ESMTP id S266054AbTHOQBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:01:50 -0400
Subject: Re: [PATCH] call drv->shutdown at rmmod
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <m1oeyrx7mo.fsf@frodo.biederman.org>
References: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
	 <1060937467.13316.39.camel@gaston>  <m1oeyrx7mo.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060963263.643.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 18:01:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even if kexec is not brought into the picture the devices need to be quiesed on
> reboot.  On x86 and probably other architectures there are 2 ways a reboot can go.
> 1) The firmware when it regains control toggles the motherboard reset
>    line resetting all of the devices, so nothing we do really makes a difference.
> 2) The firmware when it regains control tweaks a few things and
>    pretends it was never out of control, and restarts the boot
>    process.
> 
> When the firmware does not toggle the motherboard reset line during a
> reboot the firmware case is exactly equivalent to the kexec one.
> 
> So shutdown needs to quiese things.

Yup, my point was mostly to say that quiescing for shutdown and putting
in low power state are 2 different things, and that the "shutdown" name
for the callback is a bit misleading...

Ben.

