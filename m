Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVKPHGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVKPHGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVKPHGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:06:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:34449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750968AbVKPHGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:06:54 -0500
Date: Tue, 15 Nov 2005 22:41:23 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: overlapping resources for platform devices?
Message-ID: <20051116064123.GA31824@kroah.com>
References: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 05:31:57PM -0600, Kumar Gala wrote:
> Guys,
> 
> I was wondering if there was any issue in changing platform_device_add to
> use insert_resource instead of request_resource.  The reason for this
> change is to handle several cases where we have device registers that
> overlap that two different drivers are handling.
> 
> The biggest case of this is with ethernet on a number of PowerPC based 
> systems where a subset of the ethernet controllers registers are used for 
> MDIO/PHY bus control.  We currently hack around the limitation by having 
> the MDIO/PHY bus not actually register an memory resource region.
> 
> If the following looks good I'll send a more formal patch.

Looks good to me, but Russell knows this code much better than I.

thanks,

greg k-h
