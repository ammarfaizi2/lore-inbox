Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVEPVmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEPVmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVEPVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:42:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:22948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261910AbVEPVkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:40:03 -0400
Date: Mon, 16 May 2005 13:53:58 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050516205358.GA11938@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com> <528y2flygt.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528y2flygt.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 01:14:58PM -0700, Roland Dreier wrote:
>     Greg> No, as Ben said, do not do this.  Use write.  And as you are
>     Greg> only doing 1 type of ioctl, it shouldn't be an issue.  Also
>     Greg> it will be faster than the ioctl due to lack of BKL usage :)
> 
> This is no longer true.  ioctls don't have to take the BKL now that
> struct file_operations has unlocked_ioctl and compat_ioctl.

Yes, but his patch did not use them :)

thanks,

greg k-h
