Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTINW3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTINW3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:29:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7073 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262013AbTINW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:29:23 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030913021117.GA16296@tux.linuxdev.us.dell.com>
References: <3F64A5AC.8020901@pobox.com>
	 <20030913021117.GA16296@tux.linuxdev.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063578413.2479.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 23:26:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 17:11, Matt Domsch wrote:
> system-unique disk signature to the boot disk (int13 device 80h)
> "BOOT" or something - we've got 4 bytes available in the msdos label
> for it

int 13 is still available during the 16bit boot up phase of the kernel.
It does strike me as playing with fire, but an alternative approach
might work. Read the first 4K off the boot disk, stuff it somewhere 
temporary and then in 32bit compare it with the disk starts..

