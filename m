Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVIPW4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVIPW4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVIPW4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:56:51 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:60459 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750750AbVIPW4u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:56:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nix2Tl0STGsV7OhtR/my9Dz2xc0CLArBRcrhAKI836yHvGAQ4f2j6hxmucWv8zBqysyDxpplkFeBczoM6ZLo4q0yBrglTOh0WatcGqn56iulWkGeXyDcmpEcI5hVYOYAgqX+Qv9luHSM0tuoZcnmQbBjUImTUqukKRyyHaafeRc=
Message-ID: <d120d50005091615567999d77@mail.gmail.com>
Date: Fri, 16 Sep 2005 17:56:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Cc: Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <20050916215054.GC13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
	 <200509152023.44003.dtor_core@ameritech.net>
	 <20050916080237.GD10007@midnight.suse.cz>
	 <d120d50005091608447d816585@mail.gmail.com>
	 <20050916215054.GC13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Greg KH <gregkh@suse.de> wrote:
> On Fri, Sep 16, 2005 at 10:44:36AM -0500, Dmitry Torokhov wrote:
> > I'll try fix the patch I posted last night (that implements the above,
> > or at least what Kay described with sub-devices residing under their
> > parent devices and symlinked into their classes), I believe it could
> > also be used for block, so it will be like:
> >
> > .../block/
> > |-- devices
> > |   |-- sda
> > |   |   |-- device -> ../../../../
> > |   |   |-- sda1
> > |   |   |   |-- dev
> > |   |   |   `-- device -> ../../../../../block/partitions/sda1
> > |   |   |-- sda2
> > |   |   |   |-- dev
> > |   |   |   `-- device -> ../../../../../block/partitions/sda2
> > ...
> > `-- partitions
> >    |-- sda1 -> ../../../class/block/devices/sda/sda1
> >    |-- sda2 -> ../../../class/block/devices/sda/sda2
> 
> Nah, that's a mess.  I think the proposal I had would work for both
> input and block with a minimum of disruption.  Still don't know about
> video though, David said he would take some time this weekend to get me
> some feedback, which is good, as I have to get on a 14 hour plane ride
> soon...
> 

You have to adjust udev to accept mouseX being not on /sys/class/input
level anyway so disruption is still here.

-- 
Dmitry
