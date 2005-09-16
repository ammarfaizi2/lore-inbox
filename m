Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVIPV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVIPV6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVIPV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:42381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750706AbVIPV5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:30 -0400
Date: Fri, 16 Sep 2005 14:50:54 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916215054.GC13920@suse.de>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org> <200509152023.44003.dtor_core@ameritech.net> <20050916080237.GD10007@midnight.suse.cz> <d120d50005091608447d816585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005091608447d816585@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 10:44:36AM -0500, Dmitry Torokhov wrote:
> I'll try fix the patch I posted last night (that implements the above,
> or at least what Kay described with sub-devices residing under their
> parent devices and symlinked into their classes), I believe it could
> also be used for block, so it will be like:
> 
> .../block/
> |-- devices
> |   |-- sda
> |   |   |-- device -> ../../../../
> |   |   |-- sda1
> |   |   |   |-- dev
> |   |   |   `-- device -> ../../../../../block/partitions/sda1
> |   |   |-- sda2
> |   |   |   |-- dev
> |   |   |   `-- device -> ../../../../../block/partitions/sda2
> ...
> `-- partitions
>    |-- sda1 -> ../../../class/block/devices/sda/sda1
>    |-- sda2 -> ../../../class/block/devices/sda/sda2

Nah, that's a mess.  I think the proposal I had would work for both
input and block with a minimum of disruption.  Still don't know about
video though, David said he would take some time this weekend to get me
some feedback, which is good, as I have to get on a 14 hour plane ride
soon...

thanks,

greg k-h
