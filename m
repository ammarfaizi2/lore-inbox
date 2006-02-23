Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWBWFiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBWFiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWBWFiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:38:25 -0500
Received: from [205.233.219.253] ([205.233.219.253]:40598 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750802AbWBWFiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:38:25 -0500
Date: Thu, 23 Feb 2006 00:28:09 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       gombasg@sztaki.hu, tytso@mit.edu, torvalds@osdl.org,
       kay.sievers@suse.de, penberg@cs.helsinki.fi, bunk@stusta.de,
       rml@novell.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060223052809.GN3019@conscoop.ottawa.on.ca>
References: <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222115410.1394ff82.akpm@osdl.org> <20060222202638.GA16127@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222202638.GA16127@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:26:38PM -0800, Greg KH wrote:
> 
> Another point is that some busses just don't know when all the devices
> on it are found, as there is no such state.  USB is one such bus, and I
> imagine firewire is another one.  So there is no real way for us to
> delay at insmod time for all devices to be found.

Actually, we know what's present as soon as a bus reset completes, which
is measured in microseconds (1394a) or 300ms at worst (1394-1995.)
There is the case of a device that has to boot and isn't initially
available, but it will issue a reset when it comes online and our
subsystem will do detection again if needed.

Cheers,
Jody

> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
