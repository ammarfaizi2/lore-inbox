Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265991AbUFJKOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265991AbUFJKOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUFJKOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:14:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22534 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265991AbUFJKOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:14:22 -0400
Date: Thu, 10 Jun 2004 11:14:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/3] Allow registering device without taking bus lock
Message-ID: <20040610111415.C20006@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net> <200406100145.01599.dtor_core@ameritech.net> <200406100146.25471.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406100146.25471.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Thu, Jun 10, 2004 at 01:46:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:46:23AM -0500, Dmitry Torokhov wrote:
> ChangeSet@1.1769, 2004-06-10 00:10:02-05:00, dtor_core@ameritech.net
>   sysfs: provide means for adding and removing devices to a bus without
>          taking bus' semaphore so devices can be added/removed from
>          driver's probe() and remove() methods.

Eww.  Why can't you do the same as PCMCIA and register/remove in a
separate thread?

Really though, lets not introduce this hacky solution, but come up
with a way to do it cleanly so PCMCIA doesn't have this problem
either.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
