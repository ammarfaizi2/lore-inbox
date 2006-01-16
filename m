Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWAPPH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWAPPH5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWAPPH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:07:56 -0500
Received: from soundwarez.org ([217.160.171.123]:6028 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750921AbWAPPH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:07:56 -0500
Date: Mon, 16 Jan 2006 16:07:46 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Mike Snitzer <snitzer@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: unify sysfs device tree
Message-ID: <20060116150746.GA11745@vrfy.org>
References: <20060113015652.GA30796@vrfy.org> <20060116134314.GA10813@vrfy.org> <170fa0d20601160703p68e582ecq54ade82940b6d6cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d20601160703p68e582ecq54ade82940b6d6cb@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:03:06AM -0500, Mike Snitzer wrote:
> On 1/16/06, Kay Sievers <kay.sievers@vrfy.org> wrote:
> 
> > Here is an updated patch, that:
> >   o moves the devices in /sys/block to /sys/devices to match the
> >     class layout. Block devices will be childs of their physical
> >     device chain like every other class device too. Partitions
> >     will be childs of the disk device. A usual DEVPATH looks like:
> >       /devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1
> >
> >   o flattens the block class view and moves the block symlinks to
> >     /sys/class/block. Disks and partitons like /sys/class/block/sda
> >     and /sys/class/block/sda1 will be at the same level. /sys/block
> >     does not longer exist.
> 
> What is the problem with maintaining compatibility by having
> /sys/block be a symlink to /sys/class/block?  Userspace applications
> shouldn't have to now conditionalize the path to block devices
> (/sys/block/... vs /sys/class/block/...).  Forcing this kind of change
> is what taints Linux for use in hardened applications. 
> Conditionalizing code for 2.4 vs 2.6 is understandable but having to
> do so for minor 2.6.x revisions is rediculous.  <insert ref to Linus'
> views in the recent 'userspace breakage' thread here>.

Please read the whole mail before wasting other peoples time:

> I've removed all historical stuff like the "device" and "bus" link,
> cause they don't make sense anymore. What we will actually remove with
> the real conversion, does nobody know at this point.

Thanks,
Kay
