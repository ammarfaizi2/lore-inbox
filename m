Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSJPP2q>; Wed, 16 Oct 2002 11:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265038AbSJPP2q>; Wed, 16 Oct 2002 11:28:46 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30475 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265033AbSJPP2p>;
	Wed, 16 Oct 2002 11:28:45 -0400
Date: Wed, 16 Oct 2002 08:34:31 -0700
From: Greg KH <greg@kroah.com>
To: Joseph Wenninger <jowenn@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb CF reader and 2.4.19
Message-ID: <20021016153431.GC23287@kroah.com>
References: <1034760128.1306.4.camel@jowennmobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034760128.1306.4.camel@jowennmobile>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:22:04AM +0200, Joseph Wenninger wrote:
> Hi
> 
> Is there anything I can do to flush all usb / usb storage buffers to my
> compact flash ? 
> 
> At the moment I have to rmmod usb-storage && rmmod usb-uhci && modprobe
> usb-uhci && modprobe usb-storage to ensure all data is written
> correctly, otherwise the directory structure isn't saved even after an
> unmount.
> 
> Is there an application, function call, ioctl, .... which I can use,
> instead of the above mentioned inconvenient way ?

sync(1) and then umount(8) doesn't flush everything to the device?

thanks,

greg k-h
