Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVEBJba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVEBJba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVEBJba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:31:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:44674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261162AbVEBJb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:31:26 -0400
Date: Mon, 2 May 2005 02:30:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Message-Id: <20050502023047.4c965f3e.akpm@osdl.org>
In-Reply-To: <200505021200.10313.arvidjaar@mail.ru>
References: <200505012021.56649.arvidjaar@mail.ru>
	<Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
	<20050501153051.2471294e.akpm@osdl.org>
	<200505021200.10313.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
>  > It's pretty simple to convert khubd to use the kthread API.  Something like
>  > this (untested):
>  >
> 
> 
>  Something strange is going on with this patch.
> 
>  insmod usbcore; insmod uhci-hcd works as expected, finds out all devices, 
>  triggers hotplug etc. But
> 
>  {pts/2}% sudo insmod ./usbcore.ko
>  {pts/2}% sudo mount -t usbfs -o devmode=0664,devgid=43 none /proc/bus/usb
>  {pts/2}% sudo modprobe usb-interface
> 
>  results in
> 
> ...
>  uhci_hcd 0000:00:1f.2: Unlink after no-IRQ?  Controller is probably using the 
>  wrong IRQ.
>  usb 1-1: khubd timed out on ep0out

Does this only happen when the convert-khubd-to-kevent patch is applied?
