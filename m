Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVKHSsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVKHSsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVKHSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:48:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:55454 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030297AbVKHSsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:48:21 -0500
Date: Tue, 8 Nov 2005 10:46:38 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove USB_AUDIO and USB_MIDI drivers
Message-ID: <20051108184638.GA15939@suse.de>
References: <20051108181239.GB3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108181239.GB3847@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 07:12:39PM +0100, Adrian Bunk wrote:
> Since I've gotten exactly zero negative feedback, this patch removes the 
> obsolete USB_AUDIO and USB_MIDI drivers.
> 
> It also makes the global function usb_get_string() static since this 
> function no longer has any external user.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/usb/Makefile         |    2 
>  drivers/usb/class/Kconfig    |   47 
>  drivers/usb/class/Makefile   |    2 
>  drivers/usb/class/audio.c    | 3870 -----------------------------------
>  drivers/usb/class/audio.h    |  110 
>  drivers/usb/class/usb-midi.c | 2154 -------------------
>  drivers/usb/class/usb-midi.h |  164 -
>  drivers/usb/core/message.c   |    5 
>  include/linux/usb.h          |    2 
>  9 files changed, 2 insertions(+), 6354 deletions(-)
> 
> Due to it's size, the patch is attached gzip'ed.

Ugh, care to send it not gziped?  I can handle large patches...

And please split the get_string one out into a separate patch.

thanks,

greg k-h
