Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSB0EMw>; Tue, 26 Feb 2002 23:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291989AbSB0EMn>; Tue, 26 Feb 2002 23:12:43 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:46859 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291878AbSB0EMd>;
	Tue, 26 Feb 2002 23:12:33 -0500
Date: Tue, 26 Feb 2002 20:06:06 -0800
From: Greg KH <greg@kroah.com>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-dj2 compile failures
Message-ID: <20020227040606.GF3353@kroah.com>
In-Reply-To: <3C7C4BBF.2020505@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7C4BBF.2020505@fuse.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 30 Jan 2002 01:30:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 10:00:15PM -0500, Nathan wrote:
> First the good news - it built the ALSA modules correctly this time around.
> 
> And I suspect these are trivial fixes:
>    USB storage fails by trying to reference "address" member of a 
> scatterlist, which has a vdma_address (MIPS) or a dma_address (x86) 
> (didn't check others).
>        USB Mass Storage is modular, all sub drivers selected.
> 
>        This affects datafab.c and jumpshot.c.

Known problem, it's in 2.5.5 clean too.  Go bug the usb-storage
author/maintainer about it if you really need to use the datafab or
jumpshot portions of the driver.  If not, I'd recommend just turning
those CONFIG items off for now.

thanks,

greg k-h
