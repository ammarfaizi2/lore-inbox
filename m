Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUJPAh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUJPAh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJPAh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:37:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267866AbUJPAhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:37:25 -0400
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416FEC63.2911.2A62355@localhost>
References: <416FB29A.11731.1C46848@localhost>
	 <416FEC63.2911.2A62355@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097883268.9857.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 16 Oct 2004 00:34:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 23:27, Kendall Bennett wrote:
> Right. I haven't yet figured out how to mark the code as __init so it can 
> get tossed out, although if we use the VESA driver after the fact you 
> would want to keep it around in that case. But to just boot the card and 
> use say the Radeon FB driver it would be nice to toss out the code.

Every function that starts __init, and every data object starting
__initdata gets magically blown away at the end of boot.

ie

	int __init messy_horrible_boot_function(blah)

> Also is it possible to run X on a machine that is running from a serial 
> console and have it start up on the graphics card at that point? I

Yes


