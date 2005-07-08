Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVGHW27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVGHW27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVGHW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:26:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:49060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262935AbVGHW0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:26:18 -0400
Date: Fri, 8 Jul 2005 15:24:38 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Message-ID: <20050708222438.GA22141@kroah.com>
References: <B37DF8F3777DDC4285FA831D366EB9E20730C7@ausx3mps302.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B37DF8F3777DDC4285FA831D366EB9E20730C7@ausx3mps302.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:54:07PM -0500, Abhay_Salunke@Dell.com wrote:
> > Also, why not just add the hotplug flag to the firmware structure?
> That
> request_firmware kmalloc's the firmware structure and frees it when
> returned. The only way to indicate request_firmware to skip hotplug was
> by passing a hotplug flag on the stack. 

Ok, how about changing the function to pass in a flag saying what it
wants (wait/nowait, hotplug/nohotplug) and fix up all callers of it?

> > way you don't have to add another function just to add another flag.
> > And you could probably get rid of the nowait version in the same way.
> Also thought of leaving request_firmware_nowait intact didn't want to
> break others using this function.

Did you find any other in-kernel use of request_firmware_nowait?  I
don't see any :)

thanks,

greg k-h
