Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264845AbTIJGNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTIJGNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:13:23 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:43461 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264845AbTIJGNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:13:21 -0400
Date: Wed, 10 Sep 2003 16:12:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@suse.cz>
Cc: mochel@osdl.org, benh@kernel.crashing.org, axboe@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PM] Passing suspend level down to drivers
Message-Id: <20030910161243.42808c95.sfr@canb.auug.org.au>
In-Reply-To: <20030909230755.GG211@elf.ucw.cz>
References: <20030909225410.GD211@elf.ucw.cz>
	<Pine.LNX.4.44.0309091604070.695-100000@cherise>
	<20030909230755.GG211@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 01:07:55 +0200 Pavel Machek <pavel@suse.cz> wrote:
>
> I'd not worry about runtime states for now. [If user wants to sleep
> one device, we probably can allow that, but I do not think it is
> reasonable to do much more for 2.6.X]. That leaves us with:
> 
> APM suspend-to-ram
> APM suspend-to-disk

We do not know which of these is going to happen, it is entirely up to
the BIOS writers and the BIOS configuration ... i.e. on my laptop, I
have two suspend buttons - one for suspend to ram, one for suspend to disk,
but under APM the kernel merely gets a SUSPEND event no matter which
button I press.

However, there is APM standby

On another note, APM does allow for individual device power management
(i.e. you can tell the BIOS "suspend the first disk" or "power off
all displays").  I have been wondering if we want to disable the BIOS's
device power management now that we are begining to do it ourselves.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
