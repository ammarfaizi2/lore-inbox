Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTLDWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLDWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:22:26 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:24704
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263387AbTLDWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:22:24 -0500
Date: Thu, 4 Dec 2003 17:21:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jason Walker <jason_walker@bellsouth.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Unable to address 1GB RAM in 2.4.19 or later
In-Reply-To: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian>
Message-ID: <Pine.LNX.4.58.0312041709290.27578@montezuma.fsmlabs.com>
References: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, Jason Walker wrote:

> I have run into an issue where I cannot address all of my 1GB of RAM. 2.4.18
> was the last kernel that can address all 1GB. All kernels since then appear to
> only be able to address 16mb of ram if I use the 4GB himem kernel option. Here
> is a snip of the dmesg on the working 2.4.18 and broken 2.4.23 kernels:
>
> ==> dmesg-2.4.18-4GB <==
> Linux version 2.4.18-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
> prerelease)) #3 SMP Mon Apr 7 05:29:01 EDT 2003
> BIOS-provided physical RAM map:
>  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
> 128MB HIGHMEM available.
> found SMP MP-table at 000f4ff0
> hm, page 000f4000 reserved twice.
> hm, page 000f5000 reserved twice.
> hm, page 000fb000 reserved twice.
> hm, page 000fc000 reserved twice.
>
> ==> dmesg-2.4.23-4GB <==
> Linux version 2.4.23-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
> prerelease)) #1 SMP Wed Dec 3 10:28:26 EST 2003
> BIOS-provided physical RAM map:
>  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
> user-defined physical RAM map:
>  user: 0000000000000000 - 000000000009f000 (usable)
>  user: 0000000000100000 - 0000000001000000 (usable)
> 0MB HIGHMEM available.
> 16MB LOWMEM available.
> found SMP MP-table at 000f4ff0
>
> What concerns me about these is that even in the 2.4.18 kernel it only reports
> 128MB HIGHMEM in the dmesg, even though it does see all 1GB when booted (free
> confirms this). I am thinking 2.4.18 isnt detecting something properly either,
> but is only a problem in 2.4.19 and later.

You have 896M lowmem + 128M highmem.

> Both are SMP kernels. The hardware is a Compaq Proliant 5000R, quad pentium pro
> 200mhz (256k cache models).
> Any thoughts on this? Is there any other information needed to address this
> issue? Please let me know what I can do to assist in correcting this bug.

You are using mem= what happens without it? I wonder if mem= is broken
again.
