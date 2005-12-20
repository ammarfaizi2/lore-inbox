Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVLTMl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVLTMl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVLTMl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:41:57 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:19317 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1750984AbVLTMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:41:56 -0500
Date: Tue, 20 Dec 2005 07:41:29 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [RFC] Let non-root users eject their ipods?
In-reply-to: <20051220074652.GW3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Message-id: <1135082490.16754.0.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1135047119.8407.24.camel@leatherman>
 <20051220074652.GW3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 08:46 +0100, Jens Axboe wrote:
> On Mon, Dec 19 2005, john stultz wrote:
> > All,
> > 	I'm getting a little tired of my roommates not knowing how to safely
> > eject their usb-flash disks from my system and I'd personally like it if
> > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > suid the eject command, but that seems just as bad as changing the
> > permissions in the kernel (eject wouldn't be able to check if the user
> > has read/write permissions on the device, allowing them to eject
> > anything).
> 
> This just came up yesterday, eject isn't opening the device RDWR hence
> you have a permission problem with a command requiring write
> permissions. So just fix eject, there's no need to suid eject or run it
> as root.

Yep, and here's the patch to do it:

http://bugzilla.ubuntu.com/attachment.cgi?id=5415

Still, this whole issue with ALLOW_MEDIUM_REMOVAL. Would be nice if
CDROMEJECT just did the right thing.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

