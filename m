Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbUKDSgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUKDSgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbUKDSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:34:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:18067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262323AbUKDRoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:44:23 -0500
Date: Thu, 4 Nov 2004 09:44:11 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Germano <germano.barreiro@cyclades.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104174411.GE16389@kroah.com>
References: <1099487348.1428.16.camel@tsthost> <20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com> <20041104142925.GB9431@logos.cnet> <523bzpo6m2.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523bzpo6m2.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 09:40:21AM -0800, Roland Dreier wrote:
>     Marcelo> ------ Greg answer was:
> 
>     Greg> For a driver only attribute, you want them to show up in the
>     Greg> place for the driver (like under
>     Greg> /sys/bus/pci/driver/MY_FOO_DRIVER/).  To do that use the
>     Greg> DRIVER_ATTR() and the driver_add_file() functions.  For
>     Greg> examples, see the other drivers that use these functions.
> 
> I think Greg may have misunderstood the question and told you how to
> expose per-driver attributes.  But I think the attributes you want
> really are per-device and should be attached to the class_device, not
> the driver.

Heh, yes.  Per-driver attributes go in the driver's directory.  Per port
attributes go in the port's directory.  Simple as that :)

thanks,

greg k-h
