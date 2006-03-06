Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752337AbWCFJX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbWCFJX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbWCFJX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:23:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752334AbWCFJX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:23:27 -0500
Date: Mon, 6 Mar 2006 01:21:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: 2.6.16-rc5-mm2 compile error in urb.c
Message-Id: <20060306012141.5d8ca46f.akpm@osdl.org>
In-Reply-To: <440BFC8A.1030607@aitel.hist.no>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	<440BFC8A.1030607@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
> Compiling 2.6.16-rc5-mm2 stopped here:
> 
>   CC      drivers/usb/core/urb.o
> drivers/usb/core/urb.c: In function ___usb_alloc_urb___:
> drivers/usb/core/urb.c:65: error: dereferencing pointer to incomplete type
> drivers/usb/core/urb.c: In function ___usb_submit_urb___:
> drivers/usb/core/urb.c:329: error: dereferencing pointer to incomplete type
> make[3]: *** [drivers/usb/core/urb.o] Error 1
> make[2]: *** [drivers/usb/core] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 

I guess this is gregkh-usb-usb-reduce-syslog-clutter.patch trying to
dereference THIS_MODULE when the driver is being built into vmlinux.  I
suggest you revert that patch, thanks.

