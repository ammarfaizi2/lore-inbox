Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264847AbUDWP25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbUDWP25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbUDWP24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:28:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:30643 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264844AbUDWP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:28:55 -0400
Date: Fri, 23 Apr 2004 08:28:31 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423152830.GA12126@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404230142.46792.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 01:42:45AM -0500, Dmitry Torokhov wrote:
> The latest change in sysfs/symlink (conversion to use kobject_name instead
> of name fiedld directly) broke atmel_cs driver:

That's because that driver is broken in the first place.  Let me repeat:
	NEVER DECLARE A STRUCT DEVICE STATICALLY!!!

Your workaround is just that, a workaround for something that is already
broken, please fix it up correctly, and do not paper over the real root
problem...

The fact that it hasn't oopsed before this symlink fix is only a lucky
accident.

thanks,

greg k-h
