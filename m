Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUIWTbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUIWTbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIWTbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:31:14 -0400
Received: from port488.ds1-ly.adsl.cybercity.dk ([212.242.145.51]:54342 "EHLO
	tux.fubar.dk") by vger.kernel.org with ESMTP id S268158AbUIWTbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:31:12 -0400
Subject: Re: USB Media card - works at boot-up, removal works, re-insert
	doesn't
From: David Zeuthen <david@fubar.dk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: HAL list <hal@freedesktop.org>, kde-devel@mail.kde.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040921214842.GJ1105@lkcl.net>
References: <20040921180217.GE1105@lkcl.net>
	 <1095792743.5501.29.camel@localhost.localdomain>
	 <20040921202911.GH1105@lkcl.net>
	 <1095800905.4970.8.camel@localhost.localdomain>
	 <20040921214842.GJ1105@lkcl.net>
Content-Type: text/plain
Date: Thu, 23 Sep 2004 21:31:40 +0200
Message-Id: <1095967901.4573.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 (2.0.0-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tue, 2004-09-21 at 22:48 +0100, Luke Kenneth Casson Leighton wrote:
> > To me, it seems like a severe kernel bug if a userspace process,
> > *especially* if it's unprivileged, can keep the kernel from emitting
> > hotplug remove events when a device is physically detached. It would be
> > interesting to create a minimal program to reproduce this.
> 
> that's quite straightforward: i guess that an appx 30 character perl program
> or a 3 line python program 'd do the job.
> 
> or just using opendir() in c, here y'go...
> 

I can indeed reproduce this.

> [of course, changing it to "umount -lf" _also_ solves the
>  problem by making konqueror break: result, after the first remove,
>  you have to manually close konqueror, insert the media, remove
>  the media card (again), reinsert it (again), re-run konqueror]
> 

Even using 'umount -lf' doesn't work for me; I'm using the Fedora
Rawhide 2.6.8-1.584 kernel which is pretty close to 2.6.9-rc2-bk5. So
there we have it: unprivileged user can delay hotplug events for as long
as he likes. Yikes!

Thanks,
David

