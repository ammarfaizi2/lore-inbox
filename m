Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJWXyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTJWXyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:54:15 -0400
Received: from hera.kernel.org ([63.209.29.2]:44219 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261872AbTJWXyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:54:14 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: r8169 bug in 2.4.22, too much work at interrupt indefinitely
Date: Thu, 23 Oct 2003 16:53:42 -0700
Organization: Open Source Development Lab
Message-ID: <20031023165342.79e927b5.shemminger@osdl.org>
References: <1066952294.616b72c0sandos@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Trace: build.pdx.osdl.net 1066953215 3270 172.20.1.60 (23 Oct 2003 23:53:35 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 23 Oct 2003 23:53:35 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by hera.kernel.org id h9NNrZcd024393
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003 01:38:14 +0200
"John Bäckstrand"  <sandos@home.se> wrote:

> The r8169 driver in 2.4.22 with or without debian patches/acpi/usb devices sharing the same interrupt: the driver always ends up locking the machine by having indefinitely much to do in the interrupt handler? 
> 
> Commented the printk out, still hangs the machine anyway. It happens even without a cable in the card. I have found no references to any bug reports at all with this card, and I cant see any bugfixes being in 2.5/2.6 but not 2.4 either. I can see the card TX/RX:ing a few hundred packets or more (3-60 secs) before hanging.
> 
> Any way to debug this, or should I just try 2.6?
> 
> ---
> John Bäckstrand

2.6 will have the same problem.   I have a version that uses NAPI that shouldn't hang.
It seems to work fine, but didn't want to submit it without more testing.


