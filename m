Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbUKDRqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUKDRqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUKDRpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:45:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:27282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262320AbUKDRnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:43:05 -0500
Date: Thu, 4 Nov 2004 09:40:44 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Germano <germano.barreiro@cyclades.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104174044.GC16389@kroah.com>
References: <1099487348.1428.16.camel@tsthost> <20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fz3po8k2.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 08:58:21AM -0800, Roland Dreier wrote:
>     Marcelo> The problem was class_simple only contains the "dev"
>     Marcelo> attribute. You can't add other attributes to it.
> 
> I believe, based on the comment in class_simple.c:
> 
>   Any further sysfs files that might be required can be created using this pointer.
> 
> and the implementation in in drivers/scsi/st.c, that there's no
> problem adding attributes to a device in a simple class.  You can just
> use class_set_devdata() on your class_device to set whatever context
> you need to get back to your internal structures, and then use
> class_device_create_file() to add the attributes.
> 
> I assume this is OK (since there is already one in-kernel driver doing
> it), but Greg, can you confirm that it's definitely OK for a driver to
> use class_set_devdata() on a class_device from class_simple_device_add()?

Hm, I think that should be ok, but I'd make sure to test it before
verifying that it really is :)

thanks,

greg k-h
