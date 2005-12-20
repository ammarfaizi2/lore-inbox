Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVLTGGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVLTGGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 01:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLTGGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 01:06:19 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:26021 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbVLTGGT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 01:06:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DGjRAzIxcst6KerVsR6HkK2khEn9hDWDAwVU3e9iBL0+7bQQlv6/g/TpvZ9XCNJoXateJb3gfhmNKF0mG82bwXMwVIGlfE/bhowGTs6o4jcMEu2g7L86dnhYhZ5YUUucRLdywXe7Qmjq/Y4d82Z1+h4TXRY9zwXyALZML+ZO0Bg=
Message-ID: <2cd57c900512192206g7292cb1m@mail.gmail.com>
Date: Tue, 20 Dec 2005 14:06:17 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [RFC] Let non-root users eject their ipods?
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com, axboe@suse.de, vandrove@vc.cvut.cz, aia21@cam.ac.uk,
       akpm@osdl.org
In-Reply-To: <20051220051821.GM15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135047119.8407.24.camel@leatherman>
	 <20051220051821.GM15993@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/20, Willy Tarreau <willy@w.ods.org>:
> Hi John,
>
> On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
> > All,
> >       I'm getting a little tired of my roommates not knowing how to safely
> > eject their usb-flash disks from my system and I'd personally like it if
> > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > suid the eject command, but that seems just as bad as changing the
> > permissions in the kernel (eject wouldn't be able to check if the user
> > has read/write permissions on the device, allowing them to eject
> > anything).
>
> You may find my question stupid, but what is wrong with umount ? That's
> how I proceed with usb-flash and I've never sent any eject command to
> it (I even didn't know that the ioctl would be accepted by an sd device).

IMHO, umount doesn't guarantee sync, isn't it? That's similar to why
users should press sysrq-s after sysrq-u.

(CC: Petr Vandrovec, Anton Altaparmakov, Andrew Morton)

-- coywolf
