Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279616AbRJ2Xgw>; Mon, 29 Oct 2001 18:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279637AbRJ2Xgl>; Mon, 29 Oct 2001 18:36:41 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:26120 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S279636AbRJ2Xg0>;
	Mon, 29 Oct 2001 18:36:26 -0500
Date: Mon, 29 Oct 2001 15:35:26 -0800
From: Greg KH <greg@kroah.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13 errors and warnings
Message-ID: <20011029153526.F14857@kroah.com>
In-Reply-To: <20011028100317.C8059@kroah.com> <Pine.LNX.4.33.0110291205560.29385-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110291205560.29385-100000@vaio>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 12:17:02PM +0100, Kai Germaschewski wrote:
> 
> The best option, of course, is to move drivers to the new-style pci or 
> whatever interface, such that the table actually gets used. But the 
> middle of a stable series is not necessarily the best time to do so.

That's not the problem for the usb-serial drivers.  The
MODULE_DEVICE_TABLE referenced structure is only needed if the drivers
are compiled as modules.  The code uses a different usb_device_id
structure to register itself with the usb-serial core (see the code for
the reason why.)

Keith's proposed change looks like it will solve this problem nicely.

thanks,

greg k-h
