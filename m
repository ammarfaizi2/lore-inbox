Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbTI2QlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTI2QlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:13543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263703AbTI2QlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:41:06 -0400
Date: Mon, 29 Sep 2003 09:41:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
Message-Id: <20030929094136.0b4bb026.akpm@osdl.org>
In-Reply-To: <20030929155042.53666.qmail@web40910.mail.yahoo.com>
References: <20030929155042.53666.qmail@web40910.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> wrote:
>
> I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
>  with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
>  support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
>  gpm causes defunct event/0 processes to be created. 

Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?

You could try reverting synaptics-reconnect.patch, and then serio-reconnect.patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1/broken-out

