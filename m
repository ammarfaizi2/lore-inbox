Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313275AbSDDRcz>; Thu, 4 Apr 2002 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313276AbSDDRcp>; Thu, 4 Apr 2002 12:32:45 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:16906 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313275AbSDDRca>;
	Thu, 4 Apr 2002 12:32:30 -0500
Date: Thu, 4 Apr 2002 09:31:03 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] linux-2.5.8-pre1/drivers/usb/uhci.o locks up hard
Message-ID: <20020404173102.GE15918@kroah.com>
In-Reply-To: <200204041410.GAA02032@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 07 Mar 2002 14:45:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 06:10:36AM -0800, Adam J. Richter wrote:
> 	I have not analyzed this problem fully and it's not particularly
> urgent, but I thought I ought to report it just to make it part of
> the knowledge base.
> 
> 	linux-2.5.8-pre1/drivers/usb/uhci.o locks up hard after printing
> "hub.c: 2 ports detected" on both my Sony Picturebook PCG-C1VN (Transmeta)
> and a Pentium 3 desktop machine with a VIA chipset.  Oddly, uhci.o seems
> to be fine on my older Kapok 1100m Pentium 2 notebook.  I believe uhci.o
> gave me null pointer dereferences or something similar on my Picturebook
> under 2.5.7 also.

Are you running with CONFIG_DEBUG_SLAB enabled and CONFIG_SMP?
I have the same problem running with this configuration, and the uhci.c
driver author knows about it and is working on tracking down the
problem.

thanks,

greg k-h
