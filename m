Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbTCRB2R>; Mon, 17 Mar 2003 20:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbTCRB2R>; Mon, 17 Mar 2003 20:28:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3846 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262076AbTCRB2R>;
	Mon, 17 Mar 2003 20:28:17 -0500
Date: Mon, 17 Mar 2003 17:27:18 -0800
From: Greg KH <greg@kroah.com>
To: "Mark D. Studebaker " <mds@paradyne.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] driver core support for i2c bus and drivers
Message-ID: <20030318012718.GB4904@kroah.com>
References: <20030310072337.GJ6512@kroah.com> <3E6D0D25.26B5584F@attbi.com> <3E7676F7.40209@paradyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7676F7.40209@paradyne.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 08:31:35PM -0500, Mark D. Studebaker  wrote:
> 
> our userspace tools use the /proc/bus/i2c file and (of course) the entire
> tree of exported sysctl info under /proc/sys/dev/sensors
> (as implemented in i2c-proc.c).

Right now, the /proc and sysctl code is not changed at all.

However, the end goal will be to remove the /proc and sysctl code
entirely, and just use sysfs, as this is exactly what sysfs is for.  I
know, in order to do this properly the userspace library will need to be
changed, and I'm willing to do this work too.  I do not want to break
userspace compatibility needlessly.

I'll not remove anything until the same functionality can be achieved,
is this ok?  I will, of course, provide patches that for people to
evaluate, when it's working...

> Does your proposal or Cristoph's recent changes affect these?

Christoph's changes preserve the existing code, but make it work without
oopses :)

thanks,

greg k-h
