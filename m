Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTFCUNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTFCUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:13:01 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:57562 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264115AbTFCUM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:12:59 -0400
Date: Tue, 3 Jun 2003 15:26:56 -0400
From: Ben Collins <bcollins@debian.org>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603192656.GE10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com> <20030603113636.GX10102@phunnypharm.org> <1054663917.4967.99.camel@jma1.dev.netgem.com> <20030603185421.GB10102@phunnypharm.org> <1054671619.4951.139.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054671619.4951.139.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Please take a look at this session:
> First, I reboot the Ibook:

You didn't read a damn thing.

Look, things changed around rc2. They changed because the old way of
sbp2 that allowed sbp2 devices to be detected on module load caused
oopses. It was very buggy and very bad. Even the old logic didn't work
when you loaded sbp2 and _then_ plugged the device in.

I HAVE NOT once said anything about fucking /sbin/hotplug, nor the
kernel's idea of CONFIG_HOTPLUG. I just said "hotplug", which is a
generic term for being able to insert devices after the bus has already
been scanned for them. So stop bring up either of the two previous
notions that you may have.

Your behavior is expected, even if it changed and is inconvient to you.
This time, _really_ read the linux1394-devel mailing list archives. And
just get the damn script and use it. If you had ever really used sbp2
previously and wanted to plug/unplug devices without unloading/reloading
sbp2.o, you would already realize that the script was a must for 2.4.
Then again, if you had been unloading/loading sbp2 you would have also
hit the oopses I mentioned before.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
