Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUE2Oku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUE2Oku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUE2Oku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:40:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:37258 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264946AbUE2Okg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:40:36 -0400
Date: Sat, 29 May 2004 07:39:41 -0700
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@suse.de>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-BK usb (printing) broken
Message-ID: <20040529143941.GA12257@kroah.com>
References: <20040529140757.GA16264@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529140757.GA16264@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 04:08:00PM +0200, Jens Axboe wrote:
> 
> Something between 2.6.7-rc1 and current 2.6-BK broke usb printing here
> again. I have two printers attached:
> 
> usb 1-1: new full speed USB device using address 6
> usb 1-1: control timeout on ep0out
> usb 1-1: control timeout on ep0out
> usb 1-1: device not accepting address 6, error -110
> usb 1-1: new full speed USB device using address 7
> usb 1-1: control timeout on ep0out
> usb 1-1: control timeout on ep0out
> usb 1-1: device not accepting address 7, error -110
> 
> It's a VIA EPIA-800 board, lspci shows the following for usb:
> 
> 00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 24)
> 00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 24)

Alan, looks like your "fix the VIA controller driver" patch broke
something here, care to look into it?

thanks,

greg k-h
