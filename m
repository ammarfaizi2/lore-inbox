Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWAaXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWAaXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWAaXI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:08:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750991AbWAaXI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:08:28 -0500
Date: Tue, 31 Jan 2006 15:10:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060131151028.3a6c1c75.akpm@osdl.org>
In-Reply-To: <3aa654a40601311445t65fc9b6aqf2d565b72ded9c1a@mail.gmail.com>
References: <20060129144533.128af741.akpm@osdl.org>
	<3aa654a40601311445t65fc9b6aqf2d565b72ded9c1a@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich <avuton@gmail.com> wrote:
>
> On 1/29/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> 
> I'm getting a kernel panic on my Libretto L5 on boot, I don't have a
> serial port on this laptop, I don't have time at the moment to setup
> netconsole, and it doesn't get the full information. Hopefully this
> picture helps a bit:
> 
> http://68.111.224.150:8080/P1010306.JPG
> 
> If it doesn't help I will attempt to get a netconsole on this computer
> on the near future.

jpeg is fine.  It helps if you can get 50 rows on the screen - boot with
the appropriate `vga=' option, put SYSFONT="iso08.08" in
/etc/sysconfig/i18n, etc.

It seems that some cpufreq notifier has done a divide-by-zero.  But I can't
see any sign of which one it is.  You might get a better trace if you set
CONFIG_FRAME_POINTER=n.

If you could do those things and then prepare another photo it would really
help, thanks.
