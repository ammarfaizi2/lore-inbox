Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVGHTim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVGHTim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVGHTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:35:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:45483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262808AbVGHTeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:34:02 -0400
Date: Fri, 8 Jul 2005 12:32:12 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Message-ID: <20050708193211.GB2228@kroah.com>
References: <20050709001638.GA29546@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709001638.GA29546@abhays.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 07:16:38PM -0500, Abhay Salunke wrote:
> This is a patch which add a new function request_firmware_nowait_nohotplug 
> in firmware_calss.c  This function is exported and used by dell_rbu driver.
> It makes the file entries created by request_firmware to be agnostic to any 
> hotplug or timeout events.
> 
> Andrew , 
> Could you add this patch to the -mm tree. This patch was submitted about a
> week ago for review.

No, please do not.

> +/**
> + * request_firmware_nowait_nohotplug:
> + *
> + * Description:
> + *      Similar to request_firmware_nowait except it does not use 
> + * 	hotplug.
> + *
> + *      @cont will be called asynchronously when the firmware request is over.
> + *
> + *      @context will be passed over to @cont.
> + *
> + *      @fw may be %NULL if firmware request fails.

Wrong kerneldoc format, please fix this.

Also, why not just add the hotplug flag to the firmware structure?  That
way you don't have to add another function just to add another flag.
And you could probably get rid of the nowait version in the same way.

thanks,

greg k-h
