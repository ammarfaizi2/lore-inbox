Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVD1PnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVD1PnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVD1PnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:43:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:49540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262154AbVD1PnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:43:17 -0400
Date: Thu, 28 Apr 2005 08:43:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-Id: <20050428084313.1e69f59d.rddunlap@osdl.org>
In-Reply-To: <20050428090539.GA18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net>
	<20050427152704.632a9317.rddunlap@osdl.org>
	<20050428090539.GA18972@puettmann.net>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 11:05:40 +0200
Ruben Puettmann <ruben@puettmann.net> wrote:

> On Wed, Apr 27, 2005 at 03:27:04PM -0700, Randy.Dunlap wrote:
>  Looks like this code in init/main.c:
> > 
> > 	if (late_time_init)
> > 		late_time_init();
> > 
> > sees a garbage value in late_time_init (garbage being
> > %eax == 0x00307974.743d656c, which is "le=tty0\n",
> > as in "console=tty0").
> > 
> > How long is your kernel boot/command line?
> > Please post it.
> 
> It was boot over pxe here is the append line from the
> pxelinux.cfg/default  
> 
> APPEND vga=normal rw  load_ramdisk=0 root=/dev/nfs nfsroot=192.168.112.1:/store/rescue/sarge-amd64,rsize=8192,wsize=8192,timo=12,retrans=3,mountvers=3,nfsvers=3


Hm, no "console=tty...." at all.  That didn't help (me) much.

Does this happen consistently?

What does "gcc --version" say?

---
~Randy
