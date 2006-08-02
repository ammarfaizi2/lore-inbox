Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWHBHqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWHBHqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWHBHqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:46:34 -0400
Received: from bld-mail01.adl2.internode.on.net ([203.16.214.65]:63632 "EHLO
	mail.internode.on.net") by vger.kernel.org with ESMTP
	id S1751358AbWHBHqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:32 -0400
From: Marek Wawrzyczny <marekw1977@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Generic battery interface
Date: Wed, 2 Aug 2006 17:46:13 +1000
User-Agent: KMail/1.9.3
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@suse.cz>,
       Shem Multinymous <multinymous@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060731230145.GF3612@elf.ucw.cz> <20060802091841.8585a72a.khali@linux-fr.org>
In-Reply-To: <20060802091841.8585a72a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021746.13612.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 17:18, Jean Delvare wrote:
> Hi Pavel,
>
> > > frequently it can read from the chip. And no hardware monitoring chip I
> > > know of can tell when the monitored value has changed - you have to
> > > read the chip registers to know.
> >
> > ACPI battery can tell when values change in significant way. (Like
> > battery becoming critical).
>
> Ah, good to know. But is there a practical use for this? I'd suspect
> that the user wants to know the battery charge% all the time anyway,
> critical or not.

Yes, the user may want to know the battery state all the time, but will not 
notice the difference between the system reporting battery changes every 100 
microseconds or every 10 seconds, unless the hardware eats its battery 
sources for breakfast? 

The system cares though, very much so in fact:

If the battery becomes critical the system should either shut down or suspend 
to disk (if this is supported). 
This obviously would be triggered by some sort of daemon (powersaved comes to 
mind).
Ideally the suspend to disk or shutdown event triggers another event that 
allows any desktop to save it's state or possibly unmount shares that could 
otherwise be corrupted.

This scenario is quite different to an application reading the battery level.


Marek Wawrzyczny
