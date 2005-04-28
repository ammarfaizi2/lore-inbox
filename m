Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVD1R1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVD1R1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVD1R1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:27:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:29620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262184AbVD1R1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:27:22 -0400
Date: Thu, 28 Apr 2005 10:26:59 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should return -ENOSYS
Message-ID: <20050428172659.GA18859@kroah.com>
References: <200504280030.10214.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504280030.10214.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:30:09AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Jean Delvare has noticed that if a driver happens to declare its
> attribute as RW but doesn't provide store() method attempt to write
> into such attribute will cause spinning process as most of the
> attribute implementations return 0 in case of missing store causing
> endless retries. In some cases missing show/store will return -EPERM,
> -EACCESS or -EINVAL.
> 
> I think we should unify implementations and have them all return -ENOSYS
> (function not implemented) when corresponding method (show/store) is
> missing.

What is the POSIX standard for this?  ENOSYS or EACCESS?

Or anyone have a link that I can look this up at?

thanks,

greg k-h

