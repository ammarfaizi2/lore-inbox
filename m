Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUAaSje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAaSjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:39:33 -0500
Received: from buerotecgmbh.de ([217.160.181.99]:4483 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S265060AbUAaSjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:39:31 -0500
Date: Sat, 31 Jan 2004 19:39:56 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040131183956.GA22534@vrfy.org>
References: <20040126215036.GA6906@kroah.com> <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com> <20040131031718.GA21129@vrfy.org> <1075571697.7232.11.camel@nosferatu.lan> <20040131181559.GA22442@vrfy.org> <1075573621.7232.14.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075573621.7232.14.camel@nosferatu.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 08:27:01PM +0200, Martin Schlemmer wrote:
> On Sat, 2004-01-31 at 20:15, Kay Sievers wrote:
> 
> > > get time to test your latest patch - anything specific you need testing
> > > of ?
> > 
> > Nothing specific, I just need to know if it's working on other setups too :)
> > 
> > Just compile it with DEBUG=true and let the '/etc/hotplug.d/default/udev.hotplug'
> > symlink point to udevsend instead of udev. udevd will be automatically started.
> > On reboot the first sequence I get in the syslog is 138 and udevd is pid [51].
> > 
> > Don't mount /udev as tmpfs. udevd places its socket and lock file in there,
> > long before you mount it over. I just recognized it cause I had two
> > udevd running. /var/lock doesn't work cause it's also cleaned up after we
> > are running.
> > 
> 
> Our setup runs udev for creating /dev _very_ early, so I do not think
> this will be a problem - will let you know.

What means very early?
I would expect hotplug events before your setup runs.

Kay
