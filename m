Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWBAPLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWBAPLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBAPLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:11:53 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40595
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932467AbWBAPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:11:52 -0500
Date: Wed, 1 Feb 2006 07:11:45 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Aritz Bastida <aritzbastida@gmail.com>,
       Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Message-ID: <20060201151145.GA3744@kroah.com>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com> <7d40d7190601270230u850604av@mail.gmail.com> <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com> <7d40d7190601300323t1aca119ci@mail.gmail.com> <20060130213908.GA26463@kroah.com> <Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 03:54:22PM +0100, Jan Engelhardt wrote:
> >> 
> >> I guess I could pass three values on the same file, like this:
> >> $ echo "5  1000  500" > meminfo
> >> 
> >> I know that breaks the sysfs golden-rule, but how can I pass those
> >> values _atomically_ then? Having three different files wouldn't be
> >> atomic...
> >
> >That's what configfs was created for.  I suggest using that for things
> >like this, as sysfs is not intended for it.
> >
> Can't we just somewhat merge all the duplicated functionality between procfs,
> sysfs and configfs...

What "duplicated functionality"?  They all do different, unique things.

Patches are always welcome...

thanks,

greg k-h
