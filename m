Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUAIDiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUAIDiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:38:22 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:63158 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261659AbUAIDhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:37:54 -0500
Date: Thu, 8 Jan 2004 19:36:55 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040109033655.GK11065@ca-server1.us.oracle.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107185656.GB31827@kroah.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 10:57:00AM -0800, Greg KH wrote:
> Hm, that would work, but what about a user program that just polls on
> the device, as the rest of this thread discusses?  As removable devices
> are not the "norm" it would seem a bit of overkill to create 16
> partitions for every block device, if they need them or not.

	Um, adding all 16 partitions for a block device that has 5
defined is opposite of the intention of udev, no?  While I'd prefer the
partition code in-kernel provide hotplug events for each partition, if
it is instead scanned by udev, udev should indeed scan the partition
table.  Remember, udev should be able to give the appropriate
system-defined names for the partition, not just 'sda1'.

Joel

-- 

"Gone to plant a weeping willow
 On the bank's green edge it will roll, roll, roll.
 Sing a lulaby beside the waters.
 Lovers come and go, the river roll, roll, rolls."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
