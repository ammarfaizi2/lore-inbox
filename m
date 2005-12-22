Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVLVQwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVLVQwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVLVQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:52:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14022 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030190AbVLVQwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:52:54 -0500
Subject: Re: [RFC] Let non-root users eject their ipods?
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de
In-Reply-To: <1135248999.10383.29.camel@localhost.localdomain>
References: <1135047119.8407.24.camel@leatherman>
	 <1135248999.10383.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 08:57:19 -0800
Message-Id: <1135270639.17720.6.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 10:56 +0000, Alan Cox wrote:
> On Llu, 2005-12-19 at 18:51 -0800, john stultz wrote:
> > So below is a patch that allows non-root users to eject their ipods. (It
> > seems it should be safe_for_write() but eject opens the device for
> > RDONLY, so eject may be wrong here as well). 
> > 
> > Comments, flames?
> 
> I think its probably uninteresting to the majority of users to solve it
> that way (not that its wrong that I can see). The desktops handle
> automount/umount these days and if anything what would cover most bases
> is to teach umount a new option/fstab flag so that it will handle the
> device eject as it handles the non-root umount management.

I don't think that's necessary as I believe the desktops handle the
mount/unmount using eject (at least Gnome does on my Ubuntu system).

After using Ben's fix (suggested by Jens I believe) for the eject
command so it opens the device RDWR everything works without kernel
modifications (ends up the ALLOW_DEVICE_REMOVAL is already on the
safe_for_write list, just under a different name).

thanks
-john


