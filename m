Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSCXGiT>; Sun, 24 Mar 2002 01:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311622AbSCXGiK>; Sun, 24 Mar 2002 01:38:10 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:16651 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311618AbSCXGhz>;
	Sun, 24 Mar 2002 01:37:55 -0500
Date: Sat, 23 Mar 2002 22:37:31 -0800
From: Greg KH <greg@kroah.com>
To: Witek Krecicki <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] Oops while connecting a device to USB port (khubd)
Message-ID: <20020324063731.GA16612@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0203232149240.18904-200000@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 24 Feb 2002 03:37:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 09:52:56PM +0100, Witek Krecicki wrote:
> Oops is happening when I'm loading a module while having scanner 
> connected to USB (HP SJ 4470c) or when the module is already loaded and 
> i'm connecting the scanner. It does not depend on usb modularization: if 
> usb is in core, oopsa happens at boot time.
> WK
> P.S. ksymoops output in attachment

Do you have CONFIG_DEBUG_SLAB enabled in your .config?  If so, this is a
known bug the uhci.c author is trying to track down, please send this
info directly to him.  In the meantime, use usb-uhci.o to get your
machine to work properly.

thanks,

greg k-h
