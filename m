Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUALRRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUALRRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:17:16 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:50109 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S265309AbUALRRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:17:11 -0500
Date: Mon, 12 Jan 2004 09:16:56 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040112171656.GM11065@ca-server1.us.oracle.com>
Mail-Followup-To: Gerd Knorr <kraxel@bytesex.org>,
	linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <20040109033655.GK11065@ca-server1.us.oracle.com> <87wu81tptc.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wu81tptc.fsf@bytesex.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 10:49:03AM +0100, Gerd Knorr wrote:
> I also think you don't need *all* minors for removable media.  I
> havn't seen removable media with extended partitions so far.  IIRC zip
> floppys are using /dev/sda4 and most other ones either /dev/sda1 or
> /dev/sda directly, so we likely can catch 99% with just three device
> nodes.

	Ahh, but that's magic, and we don't want magic.  Today, you just
'magically' know that your camera card reader shows up at sda1.  We
don't want that (or at least, I hope we don't).  We want sysfs to
describe exactly what appeared (a block device with one partition), and
we want udev to give it the name our policy has asked it to (/dev/disk1
or /dev/camera1 or /dev/partition1 or whatever that policy is).  In a
udev world, I don't want to have to intrinsicly know that sda1 is where
some card reader devices appear.  Naming should be a priori, not random.

Joel

-- 

"Glory is fleeting, but obscurity is forever."  
         - Napoleon Bonaparte

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
