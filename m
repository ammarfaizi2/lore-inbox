Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVANBNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVANBNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVANBNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:13:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30117 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261839AbVANBM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:12:59 -0500
Date: Thu, 13 Jan 2005 16:59:48 -0800
From: Greg KH <greg@kroah.com>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module's parameters could not be set via sysfs in 2.6.11-rc1?
Message-ID: <20050114005948.GD4140@kroah.com>
References: <200501132234.30762.rathamahata@ehouse.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501132234.30762.rathamahata@ehouse.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:34:30PM +0300, Sergey S. Kostyliov wrote:
> Hello,
> 
> It looks like module parameters are not setable via sysfs in 2.6.11-rc1
> 
> E.g.
> arise parameters # echo -en Y > /sys/module/usbcore/parameters/old_scheme_first
> -bash: /sys/module/usbcore/parameters/old_scheme_first: Permission denied
> arise parameters # id
> uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
> arise parameters # 
> arise parameters # ls -la /sys/module/usbcore/parameters/old_scheme_first
> -rw-r--r--  1 root root 0 Jan 13 22:22 /sys/module/usbcore/parameters/old_scheme_first
> arise parameters # 
> 
> This is sad because it seems that my usb flash stick (transcebd jetflash)
> doesn't like new USB device initialization scheme introduced in 2.6.10.

I'm seeing the same problem here.  I'll dig into it later tonight.

thanks,

greg k-h
