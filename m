Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270152AbUJTHXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270152AbUJTHXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270169AbUJTHXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:23:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:43164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270163AbUJTHLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:11:55 -0400
Date: Wed, 20 Oct 2004 00:00:56 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Instances of visor us devices are not deleted (2.6.9-rc4-mm1)
Message-ID: <20041020070056.GA15620@kroah.com>
References: <20041020061647.GA20692@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020061647.GA20692@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:16:47AM +0200, Norbert Preining wrote:
> Hi USB developers!
> 
> I have the following problem with 2.6.9-rc4-mm1 which includes bk-usb:
> 
> Everytime I sync my palm I get a new device id:
> 
> ...start sync...
> usb 4-2.1: new full speed USB device using address 8
> visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
> usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB2
> usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB3
> ...
> ...many usb usb2: string descriptor 0 read error: -113 ...
> ...
> ...end of sync...
> usb 4-2.1: USB disconnect, address 8
> visor 4-2.1:1.0: device disconnected
> visor ttyUSB3: visor_write - usb_submit_urb(write bulk) failed with status = -19
> ...new sync...
> usb 4-2.1: new full speed USB device using address 9
> visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
> usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB4
> usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB5
> 
> etc etc.
> 
> Is this a known problem?

Hm, no it isn't.  Are you sure that userspace doesn't still have the
device nodes open?  If they do, the ttyUSB number will not be released
until that happens.

thanks,

greg k-h
