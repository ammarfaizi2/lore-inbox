Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbTIDSnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTIDSnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:43:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:12773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265478AbTIDSks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:40:48 -0400
Date: Thu, 4 Sep 2003 11:40:35 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] Fix conversion from milli volts in store_in_reg() for w83781d.c
Message-ID: <20030904184035.GA11160@kroah.com>
References: <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan> <20030610054107.GA22719@earth.solarsys.private> <1055401021.5280.3143.camel@workshop.saharacpt.lan> <20030613023651.GA1401@earth.solarsys.private> <1055571995.12868.5.camel@nosferatu.lan> <20030616184149.GC25585@kroah.com> <1062622452.5275.38.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062622452.5275.38.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 10:54:12PM +0200, Martin Schlemmer wrote:
> Hi
> 
> I am not sure if it was a later patch from me that fixed in_* to display
> milli volts in sysfs, or if it was a patch from Jan Dittmer, but the
> conversion in the store_in_*() functions is wrong, and cause something
> like:
> 
> ----------------------------
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 3632
> nosferatu patch # echo '3700' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch # echo '3640' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch # echo '3632' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
> nosferatu patch #
> -----------------------------
> 
> I think Andrey also noticed this (if I did not smoke too much Weedbix
> this morning ;) - if so, please verify that this fixes it ... it does
> here at least.
> 
> Anyhow, patch is attached and should apply to 2.6.0-test4-bk5.

Applied, thanks.

greg k-h
