Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbTCGXaN>; Fri, 7 Mar 2003 18:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCGXaN>; Fri, 7 Mar 2003 18:30:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26119 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261893AbTCGXaK>; Fri, 7 Mar 2003 18:30:10 -0500
Date: Fri, 7 Mar 2003 23:39:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030307233916.Q17492@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 07, 2003 at 03:05:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:05:32PM -0800, Linus Torvalds wrote:
> However, I also have to say that klibc is pretty late in the game, and as 
> long as it doesn't add any direct value to the kernel build the whole 
> thing ends up being pretty moot right now. It might be different if we 
> actually had code that needed it (ie ACPI in user space or whatever).

Alan was recently trying to convince people that ipconfig.c should be
deleted from the 2.5 kernel today.  That was until I pointed out that
people do download kernels via xmodem to embedded boards (because that's
what the boot loader supports) and they want to be able to use root-NFS.
I think Alan is reasonably happy for it to stay now, although I haven't
had any hard positive confirmation of that fact.

As long as we don't have equivalent functionality present which replaces
ipconfig.c and nfsroot.c without adding stupidly sized initrd images to
the kernel, I will continue to resist the removal of both of these
features.

klibc provided a way, but if that isn't going to be merged and this stuff
made to work for 2.6, then I think we must keep ipconfig.c and nfsroot.c.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

