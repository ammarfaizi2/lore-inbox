Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293407AbSCSA6H>; Mon, 18 Mar 2002 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSCSA56>; Mon, 18 Mar 2002 19:57:58 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:2061 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293407AbSCSA5t>;
	Mon, 18 Mar 2002 19:57:49 -0500
Date: Mon, 18 Mar 2002 16:57:14 -0800
From: Greg KH <greg@kroah.com>
To: rob1@rekl.yi.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Autoconfig doesn't work for USB network devices
Message-ID: <20020319005714.GC27993@kroah.com>
In-Reply-To: <20020315230131.GC5563@kroah.com> <Pine.LNX.4.40.0203161810290.16559-100000@rekl.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Feb 2002 22:10:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 06:25:30PM -0600, rob1@rekl.yi.org wrote:
> 
> There is no perceptible delay between these messages, so it seems like the
> code to detect the USB devices executes after the IP autoconfig section,
> which is what is preventing this from working.

It looks like you need to move the delay section of that patch, possibly
changing the logic in the IP autoconfig section to delay until your
device shows up on the USB bus.

> Is this a topic that should be discussed on one of the linux-usb lists
> instead of linux-kernel?

I think this a good enough place for it, as it isn't very specific to a
USB subsystem problem.

greg k-h
