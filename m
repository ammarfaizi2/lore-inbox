Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbTCGXeQ>; Fri, 7 Mar 2003 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbTCGXeP>; Fri, 7 Mar 2003 18:34:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17168 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261899AbTCGXeO>; Fri, 7 Mar 2003 18:34:14 -0500
Message-ID: <3E692EE4.9020905@zytor.com>
Date: Fri, 07 Mar 2003 15:44:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk>
In-Reply-To: <20030307233916.Q17492@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Mar 07, 2003 at 03:05:32PM -0800, Linus Torvalds wrote:
> 
>>However, I also have to say that klibc is pretty late in the game, and as 
>>long as it doesn't add any direct value to the kernel build the whole 
>>thing ends up being pretty moot right now. It might be different if we 
>>actually had code that needed it (ie ACPI in user space or whatever).
> 
> Alan was recently trying to convince people that ipconfig.c should be
> deleted from the 2.5 kernel today.  That was until I pointed out that
> people do download kernels via xmodem to embedded boards (because that's
> what the boot loader supports) and they want to be able to use root-NFS.
> I think Alan is reasonably happy for it to stay now, although I haven't
> had any hard positive confirmation of that fact.
> 
> As long as we don't have equivalent functionality present which replaces
> ipconfig.c and nfsroot.c without adding stupidly sized initrd images to
> the kernel, I will continue to resist the removal of both of these
> features.
> 
> klibc provided a way, but if that isn't going to be merged and this stuff
> made to work for 2.6, then I think we must keep ipconfig.c and nfsroot.c.

Right, of course.  However, the first step (which Greg has accomplished)
is to get klibc merged into the kernel build.  We already have ipconfig
and mount-nfs binaries which compile against klibc; now we need to
integrate them so they can pick up the ip= and nfsroot= options and do
the right thing in userspace.

*Then* we can discuss when they should be removed.

	-hpa

