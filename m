Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUANVOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANVOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:14:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:36532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263930AbUANVOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:14:36 -0500
Date: Wed, 14 Jan 2004 13:14:17 -0800
From: Greg KH <greg@kroah.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
Message-ID: <20040114211417.GC6650@kroah.com>
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com> <4005971F.4020608@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005971F.4020608@vgertech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 07:23:11PM +0000, Nuno Silva wrote:
> This would be nice but I think that full info for every new hotplugged 
> device is even better. It's only 1 line :-)

Heh, care to make that one line patch?  :)

> Lame people, like myself, will make this rule:
> 
> BUS="scsi", SYSFS_model="CD-Writer cd4f*", KERNEL="sr*", NAME="cdrw"
> 
> When I connect a second drive (same model) /udev/cdrw will be 
> overwritten.

No, the node will not be overwritten.  The mknod() syscall will fail due
to the node already being present.  What would happen is that your new
node would not be created.

> So I'd want to check the logs, find some difference between 
> the two and create a new entry "myfriends-cdrw".
> 
> (I know that NAME="cdrw%n" would work but that depends on the order you 
> plug things).

Heh.

I'm thinking that having such a log message would be a good thing.  Now
to go figure out what log level to make those messages...

thanks,

greg k-h
