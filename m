Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbSKQAmY>; Sat, 16 Nov 2002 19:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267422AbSKQAmY>; Sat, 16 Nov 2002 19:42:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55818 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267421AbSKQAmX>;
	Sat, 16 Nov 2002 19:42:23 -0500
Date: Sat, 16 Nov 2002 16:43:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 bug - USB usbfs segvs processes
Message-ID: <20021117004322.GD28824@kroah.com>
References: <20021115174234.GB2828@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115174234.GB2828@digitasaru.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:42:34AM -0600, Joseph Pingenot wrote:
> Another bug in 2.5.47, this time with USBFS.  When attempting to read
>   /proc/bus/usb/drivers, the program reading the "file" terminates with
>   a segmentation fault:
> /proc/bus/pci:58$ cat devices 
> Segmentation fault
> $lspci
> Segmentation fault

You are trying to read /proc/bus/pci/* not /proc/bus/usb files.  So why
would you think usbfs would have a problem?

Also, a decoded oops report would help out a lot.

thanks,

greg k-h
