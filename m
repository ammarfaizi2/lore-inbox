Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290589AbSAYHiI>; Fri, 25 Jan 2002 02:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290591AbSAYHh6>; Fri, 25 Jan 2002 02:37:58 -0500
Received: from [195.163.186.27] ([195.163.186.27]:47031 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S290589AbSAYHhj>;
	Fri, 25 Jan 2002 02:37:39 -0500
Date: Fri, 25 Jan 2002 09:37:33 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ramya Ravichandran <rrhsin@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel newbie -- Compact Flash booting
Message-ID: <20020125093733.D5808@mea-ext.zmailer.org>
In-Reply-To: <20020125065237.27862.qmail@web8104.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020125065237.27862.qmail@web8104.in.yahoo.com>; from rrhsin@yahoo.co.in on Thu, Jan 24, 2002 at 10:52:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 10:52:37PM -0800, Ramya Ravichandran wrote:
> Hi,
> 
>    I am a newbie to Linux.I have to develop an
> embedded linux controller that boots from the Compact
> flash card instead of the HD and work from RAM. I have
> to have a bare minimum implementation of Linux kernel
> to do this.
>   I don't know where to start. Shud I start by writing
> the driver for the CF card? What background knowledge
> shud I have for implementing the kernel?

  The compact flashes appear to PCMCIA as removable IDE drives.
  Unless the PCMCIA-CF adapter is more than just two connectors
  plus a set of wires in between, you should have no problems
  at all.   Either IDE, or IDE_CS driver should do it.
  (The IDE_CS will, of course, need the PCMCIA suite too to
   support removable media.  IDE doesn't support removability.)

  To boot from CF you need support in your boot-rom/flash
  code.  Something which might not be true, unless you write
  it yourself..

> Please Help.Thanks

/Matti Aarnio
