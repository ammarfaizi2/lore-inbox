Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTJ0Vil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTJ0Vil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:38:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:64409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263593AbTJ0Vij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:38:39 -0500
Date: Mon, 27 Oct 2003 13:38:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mr Amit Patel <patelamitv@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
Message-Id: <20031027133859.2fcfc6de.akpm@osdl.org>
In-Reply-To: <20031027175935.15690.qmail@web13005.mail.yahoo.com>
References: <20031026034113.0cfd50d9.akpm@osdl.org>
	<20031027175935.15690.qmail@web13005.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr Amit Patel <patelamitv@yahoo.com> wrote:
>
> Hi Andrew,
> 
> The qlogic driver is for Fibre Channel HBA QLA2342.
> This is a beta driver which is part of the mjb1 patch
> against 2.6.0-test8. As a part of driver insmod,
> driver tries to find fiber channel device and maps it
> to scsi block device. Actually I don't have any fibre
> channel target attached, so driver does not find any
> scsi devices and discovery finishes without adding any
> block device. 
> 
> I am trying to go through driver scsi_scan process and
> see when does actual allocation from as_arq happens.
> But for some reason after going to kgdb I get SIGEMT
> and I cannot debug further. What is causing SIGEMT
> cause after doing some search looks like its actually
> SIGUSR but linux treats it as SIGEMT. Is there any way
> to prevent SIGEMT when I want to use kgdb ? 
> 

SIGEMT is kgdb's way of telling you the kernel oopsed.  The different
signal types used to convey useful information (a different type for NMI
watchdog expiry, for example).  But George then randomised them and I've
never worked out the new scheme...

kgdb is difficult to use with kernel modules.  There's probably a way of
doing it in 2.6 but I've never sat down and worked it out.  But as you
appear to be working on the SCSI core that's not a problem.


