Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWH2NBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWH2NBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWH2NBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:01:30 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:36235 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964903AbWH2NB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:01:29 -0400
Date: Tue, 29 Aug 2006 09:01:19 -0400
To: Gustavo Guillermo P?rez <gustavo@compunauta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
Message-ID: <20060829130119.GV13639@csclub.uwaterloo.ca>
References: <200608271239.32507.gustavo@compunauta.com> <200608271434.35840.gustavo@compunauta.com> <20060828195709.GL13641@csclub.uwaterloo.ca> <200608282042.26594.gustavo@compunauta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608282042.26594.gustavo@compunauta.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 08:42:26PM -0500, Gustavo Guillermo P?rez wrote:
> Builded into kernel we can't specify the load order, then you suggest to made 
> an initrd with insmod loading firs scsi subsystem and piix before 
> ide-generic... Ok I can do that, but imagine, making a kernel for a 
> distribution, ;)

A distribution would be using modules and an initrd/initramfs.  So yes
that is what you should do.  Or at least don't build ide generic into
the kernel if you want other chipset drivers to work.

Of course there might be some kernel command line option you could pass
to specify which driver to use, but I don't know of one.

--
Len Sorensen
