Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275610AbTHOA0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275619AbTHOAY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:24:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:32733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275615AbTHOAWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:22:40 -0400
Date: Thu, 14 Aug 2003 17:17:27 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: extra ttyS in /sys/class/tty
Message-ID: <20030815001727.GB4776@kroah.com>
References: <200308141855.31137.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308141855.31137.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 06:55:31PM +0400, Andrey Borzenkov wrote:
> {pts/1}% dmesg | grep ttyS
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS2 at I/O 0xd000 (irq = 9) is a 16550A
> 
> {pts/1}% l -d /sys/class/tty/ttyS*
> /sys/class/tty/ttyS0/  /sys/class/tty/ttyS1/  /sys/class/tty/ttyS2/
> /sys/class/tty/ttyS3/
> {pts/1}% cat /sys/class/tty/ttyS*/dev
> 4:64
> 4:65
> 4:66
> 4:67
> 
> not that I find sysfs that useful for cdevs in general but I am just curiouos 
> - where does it come from?

Someone registered a ttyS3, and they don't have to say they are doing so
in the system log :)

> I have irtty_sir loaded if it matters.

Don't know, does it register a tty driver with the tty core?

thanks,

greg k-h
