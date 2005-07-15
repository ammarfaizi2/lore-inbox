Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVGOAL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVGOAL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVGOAL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:11:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261787AbVGOAL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:11:56 -0400
Date: Thu, 14 Jul 2005 17:10:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux@kesh.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RealTimeSync Patch
Message-Id: <20050714171052.362f93dd.akpm@osdl.org>
In-Reply-To: <42D69154.6040608@kesh.com>
References: <42D69154.6040608@kesh.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elias Kesh <linux@kesh.com> wrote:
>
> Hello,
> 
> I would like to get some feedback on this patch for the kernel.  It's sole purpose is to help in reducing boot time by not waiting to synchronize the clock edge with the hardware clock. This when combined with other boot reduction patched can bring the kernel boot time to well under 10 seconds, in most cases two or three seconds.  In a desktop system this patch is probably insignificant, howerver several patches like this in a set top box or cell phone will be signicant.

Please wordwrap your emails at column 72 or thereabouts.

>  I understand that there may be some concerns with patches like these so I would like to start a discussion so that I can better understand what the issues are. The members of the CELinux Forum have quite a bit we would like to contribute.

You should send the patches to this mailing list, just as you have done here.

> Looking at the archives I see that a an intel patch was submitted back in October but I am unable to determine what the resolution was.

What patch was that?

> This patch included is for PPC but other architecutres are available on the patch web site below.

I get connection refused from tree.celinuxforum.org

> Detailed information on the patch can be found here:
> http://tree.celinuxforum.org/CelfPubWiki/RTCNoSync
> 
> In addition, other patches for boot time reduction can be found here:
> http://tree.celinuxforum.org/CelfPubWiki/PatchArchive

Finish the patches and just send them.  No fuss.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt for a few details.

> *
> Fast boot options (FASTBOOT) [N/y/?] (NEW) y
>   Disable synch on read of Real Time Clock (RTC_NO_SYNC) [N/y/?] (NEW) y
> 

This particular feature seems to be ppc-specific and hence the folks at
linuxppc-dev@lists.linuxppc.org should be involved.  Probably the
CONFIG_RTC_NO_SYNC Kconfig option should be in arch/ppc/Kconfig - one would
need to see all the patches to determine that.

It might be better to use a kernel boot option rather than another
compile-time option for this - you'd need to discuss that with other ppc
people.   Or perhaps the code in there is just being dumb and can be fixed.

In general, it's taking waaaay to long to get all these CELinux patches
into the outside world.  Thanks for getting this one on the wires.  Let's
get them all done and finish this thing.
