Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVINT5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVINT5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINT5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:57:54 -0400
Received: from ext-nj2ut-2.online-age.net ([64.14.54.231]:21176 "EHLO
	ext-nj2ut-2.online-age.net") by vger.kernel.org with ESMTP
	id S932353AbVINT5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:57:53 -0400
Date: Wed, 14 Sep 2005 14:57:38 -0500
From: Rich Coe <Richard.Coe@med.ge.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.13.1 (and 2.6.13) missing Fusion mpt devices
Message-ID: <20050914145738.36b57e21@godzilla>
In-Reply-To: <20050913092251.1bb0a871@godzilla>
References: <20050913092251.1bb0a871@godzilla>
Organization: CSE
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 09:22:51 -0500
Rich Coe <Richard.Coe@med.ge.com> wrote:
> Cannot boot with Fusion-mpt attached scsi
> I think it's because of this:
> > PCI: Cannot allocate resource region 3 of device 0000:02:05.0
> > PCI: Cannot allocate resource region 1 of device 0000:02:05.1
> > PCI: Cannot allocate resource region 3 of device 0000:02:05.1
> 
> I'm still trying to track down what the error means and how to fix it. 
> Thanks.
> 

This is due to a change in the Fusion mpt driver.

As found on a previous LKML entry:
> From	"Moore, Eric Dean" <>
> Subject	RE: can't boot 2.6.13
> Date	Thu, 8 Sep 2005 16:51:45 -0600
> 
> On Thursday, September 08, 2005 3:19 PM, Mike Miller(HP) wrote:
> > I am not able to boot the 2.6.13 version of the kernel. I've 
> > tried different systems, tried downloading again, still 
> > nothing. Here's the last thing I see from the serial port:
> > 
[ ... ]
> > Fusion MPT base driver 3.03.02
> > Copyright (c) 1999-2005 LSI Logic Corporation
> > 
> 
> We introduced split drivers for 2.6.13.  There are new layer drivers
> that sit ontop of mptscsih.ko.  These drivers are split along bus
> protocal, so there is mptspi.ko, mptfc.ko, and mptsas.ko.  This is
> to tie into the scsi transport layers that are split the same.
> 
> For 1030(a SPI controller)
> If your using RedHat, you need to change mptscish to mptspi in
> /etc/modprobe.conf.
> If your using SuSE, you need to change mptscish to mptspi in
> /etc/sysconfig/kernel

-- 
Rich Coe		richard.coe@med.ge.com
General Electric Healthcare Technologies
Global Software Platforms, Computer Technology Team
