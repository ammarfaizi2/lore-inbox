Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUBJR4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUBJR4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:56:47 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:60300 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266140AbUBJRzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:55:21 -0500
Date: Tue, 10 Feb 2004 09:55:49 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210175548.GN4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210170157.GA27421@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:01:57AM -0800, Greg KH wrote:
> Did you read:
> 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

While we're at it...

>  Problems:
>    1) devfs only shows the dev entries for the devices in the system.

Why is that a bad thing? Why should I want to see dev entries for firewire
drives on my 486 or LPT1 on my legacy-free laptop? 

>    2) devfs does not handle the need for dynamic major/minor numbers

It does as well as udev does. You say it yourself, "if the kernel switches to
dynamic major/minor". The same is true of devfs. It was designed for dynamic
major/minors, and the static ones were for backward compatibility with static
/devs.

>    4) devfs does provide a deamon that userspace programs can hook into
>       to listen to see what devices are being created or removed.

How is that a problem?

>  Constraints:
>    1) devfs forces the devfs naming policy into the kernel.  If you
>       don't like this naming scheme, tough.

Not true at all. If you don't like the naming scheme, run devfsd. Just
like running udev, only unlike udev at least you have device files even
if the daemon's not running.

>    2) devfs does not follow the LSB device naming standard.

No, but the userspace daemon attached to it could do so, just like udev.
