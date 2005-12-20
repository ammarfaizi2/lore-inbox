Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLTHpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLTHpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 02:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVLTHpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 02:45:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44636 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750822AbVLTHpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 02:45:21 -0500
Date: Tue, 20 Dec 2005 08:46:53 +0100
From: Jens Axboe <axboe@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220074652.GW3734@suse.de>
References: <1135047119.8407.24.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135047119.8407.24.camel@leatherman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, john stultz wrote:
> All,
> 	I'm getting a little tired of my roommates not knowing how to safely
> eject their usb-flash disks from my system and I'd personally like it if
> I could avoid bringing up a root shell to eject my ipod. Sure, one could
> suid the eject command, but that seems just as bad as changing the
> permissions in the kernel (eject wouldn't be able to check if the user
> has read/write permissions on the device, allowing them to eject
> anything).

This just came up yesterday, eject isn't opening the device RDWR hence
you have a permission problem with a command requiring write
permissions. So just fix eject, there's no need to suid eject or run it
as root.

-- 
Jens Axboe

