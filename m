Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUFCXPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUFCXPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUFCXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:15:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:1433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264538AbUFCXPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:15:42 -0400
Date: Thu, 3 Jun 2004 16:18:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-Id: <20040603161813.32ea0b84.akpm@osdl.org>
In-Reply-To: <200406031703.38722.dominik.karall@gmx.net>
References: <20040603015356.709813e9.akpm@osdl.org>
	<200406031703.38722.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Thursday 03 June 2004 10:53, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6
> >.7-rc2-mm2/
> 
> SiS framebuffer works here. But my kernel does not boot, it stops at
> 
> Starting hotplug subsystem:
>    input
>    net
>    pci
>      sis900: already loaded
>      8139too: already loaded
>      ignore pci display device on 01:00.0
>    usb
> 
> and right here it stops.
> 
> Normally it looks this way:
> 
> Starting hotplug subsystem:
>    input
>    net
>    pci
>      sis900: already loaded
>      8139too: already loaded
>      ignore pci display device on 01:00.0
>    usb
> done

Can you get sysrq-T output?

Can you please grab ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm2/broken-out/bk-usb.patch and do

	patch -p1 -i ~/bk-usb.patch

and retest?
